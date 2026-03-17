import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RevenueChart extends StatelessWidget {
  final List<double> data;
  final double maxY;
  final int selectedIndex;
  final double selectedValue;
  final ValueChanged<int> onSelect;

  const RevenueChart({
    super.key,
    required this.data,
    required this.maxY,
    required this.selectedIndex,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (d) {
            final w = constraints.maxWidth;
            final segW = w / (data.length - 1);
            int idx = (d.localPosition.dx / segW).round().clamp(
              0,
              data.length - 1,
            );
            onSelect(idx);
          },
          onHorizontalDragUpdate: (d) {
            final w = constraints.maxWidth;
            final segW = w / (data.length - 1);
            int idx = (d.localPosition.dx / segW).round().clamp(
              0,
              data.length - 1,
            );
            onSelect(idx);
          },
          child: CustomPaint(
            painter: ChartPainter(
              data: data,
              maxY: maxY,
              selectedIndex: selectedIndex,
              selectedValue: selectedValue,
            ),
            size: Size(constraints.maxWidth, constraints.maxHeight),
          ),
        );
      },
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;
  final double maxY;
  final int selectedIndex;
  final double selectedValue;

  ChartPainter({
    required this.data,
    required this.maxY,
    required this.selectedIndex,
    required this.selectedValue,
  });

  static const gridColor = AppColors.chartGrid;
  static const lineColor = AppColors.chartLine;
  static const labelColor = AppColors.chartLabel;
  static const yLabels = ['4K', '3K', '2K', '1K', '0'];
  static const yValues = [4000.0, 3000.0, 2000.0, 1000.0, 0.0];

  Path _getSmoothPath(List<Offset> pts) {
    if (pts.isEmpty) return Path();
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i];
      final p1 = pts[i + 1];
      // Smoother curve similar to image
      final controlX1 = p0.dx + (p1.dx - p0.dx) / 2.5;
      final controlX2 = p1.dx - (p1.dx - p0.dx) / 2.5;
      path.cubicTo(controlX1, p0.dy, controlX2, p1.dy, p1.dx, p1.dy);
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const leftPad = 36.0;
    const topPad =
        45.0; // Increased to allow more space for amount above 4K line
    const bottomPad = 4.0;
    final chartW = size.width - leftPad;
    final chartH = size.height - topPad - bottomPad;

    double xOf(int i) => leftPad + i * chartW / (data.length - 1);
    double yOf(double v) => topPad + chartH * (1 - v / maxY);

    // Grid lines + Y labels
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8;
    final labelStyle = TextStyle(
      color: labelColor,
      fontSize: 10,
      fontFamily: 'Poppins',
    );

    for (int i = 0; i < yValues.length; i++) {
      final y = yOf(yValues[i]);
      canvas.drawLine(Offset(leftPad, y), Offset(size.width, y), gridPaint);
      _drawText(
        canvas,
        yLabels[i],
        Offset(0, y - 7),
        labelStyle,
        maxWidth: leftPad - 4,
      );
    }

    // Build points
    final pts = List.generate(data.length, (i) => Offset(xOf(i), yOf(data[i])));

    // Create smooth paths
    final smoothLine = _getSmoothPath(pts);

    // Filled area
    final areaPath = Path.from(smoothLine)
      ..lineTo(pts.last.dx, size.height)
      ..lineTo(pts.first.dx, size.height)
      ..close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withValues(alpha: 0.3),
          lineColor.withValues(alpha: 0.1),
          Colors.black.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromLTWH(0, topPad, size.width, chartH + topPad));
    canvas.drawPath(areaPath, areaPaint);

    // Line
    final linePaint = Paint()
      ..color = lineColor.withValues(alpha: 0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(smoothLine, linePaint);

    // Crosshair vertical line
    final sx = pts[selectedIndex].dx;
    final crossPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0;

    // Vertical line starts slightly above the 4K line (topPad) and goes to the bottom
    canvas.drawLine(
      Offset(sx, topPad - 8),
      Offset(sx, size.height),
      crossPaint,
    );

    // Selected point dot REMOVED as requested

    // Tooltip label above 4K line
    final valText = 'SAR ${selectedValue.toStringAsFixed(2)}';
    final tooltipStyle = const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
    final tp = TextPainter(
      text: TextSpan(text: valText, style: tooltipStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    double tx = sx - tp.width / 2;
    tx = tx.clamp(leftPad, size.width - tp.width);

    // Paint text fixed at the top area, above the 4K grid line
    tp.paint(canvas, Offset(tx, topPad - 32));
  }

  void _drawText(
    Canvas c,
    String text,
    Offset pos,
    TextStyle style, {
    double maxWidth = 100,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    )..layout(maxWidth: maxWidth);
    tp.paint(c, pos);
  }

  @override
  bool shouldRepaint(ChartPainter old) =>
      old.selectedIndex != selectedIndex || old.data != data;
}
