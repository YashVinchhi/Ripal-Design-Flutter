import 'package:flutter/material.dart';

/// Custom painter for offset intersecting architectural corner borders.
class CornerLinesPainter extends CustomPainter {
  final bool isTopLeft;

  CornerLinesPainter({required this.isTopLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B2E2E)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    if (isTopLeft) {
      // Horizontal bar extending past vertical line
      canvas.drawLine(const Offset(0, 20), Offset(size.width, 20), paint);
      // Vertical bar extending past horizontal line
      canvas.drawLine(const Offset(20, 0), Offset(20, size.height), paint);
    } else {
      // Horizontal bar extending past vertical line
      canvas.drawLine(
        Offset(0, size.height - 20),
        Offset(size.width, size.height - 20),
        paint,
      );
      // Vertical bar extending past horizontal line
      canvas.drawLine(
        Offset(size.width - 20, 0),
        Offset(size.width - 20, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
