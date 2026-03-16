import 'package:flutter/material.dart';
import 'package:cab_zing/core/theme/app_colors.dart';

class GlowBackground extends StatelessWidget {
  const GlowBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: GlowPainter(),
    );
  }
}

class GlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    void drawOrb(Offset center, Color color) {
      final paint = Paint()
        ..color = color.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);
      canvas.drawCircle(center, 100, paint);
    }

    drawOrb(Offset(size.width * 0.9, size.height * 0.28), AppColors.glowCyan);
    drawOrb(Offset(size.width * 0.1, size.height * 0.28), AppColors.glowYellow);
    drawOrb(Offset(size.width * 0.25, size.height * 0.72), AppColors.glowPink);
  }

  @override
  bool shouldRepaint(GlowPainter oldDelegate) => false;
}
