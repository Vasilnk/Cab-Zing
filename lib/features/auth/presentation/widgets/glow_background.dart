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
        ..color = color
            .withValues(alpha: 0.4) // Increased opacity for more vivid colors
        ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal,
          110,
        ); // Slightly less spread out
      canvas.drawCircle(center, 100, paint); // Increased circle size
    }

    drawOrb(Offset(size.width * 0.9, size.height * 0.48), AppColors.glowCyan);
    drawOrb(Offset(size.width * 0.1, size.height * 0.28), AppColors.glowYellow);
    drawOrb(Offset(size.width * 0.25, size.height * 0.72), AppColors.glowPink);
  }

  @override
  bool shouldRepaint(GlowPainter oldDelegate) => false;
}
