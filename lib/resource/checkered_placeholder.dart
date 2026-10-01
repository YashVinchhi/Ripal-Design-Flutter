import 'package:flutter/material.dart';

/// A reusable checkerboard placeholder matching the architectural blueprint/rendering
/// placeholders used throughout the Ripal Design screenshots.
class CheckeredPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double squareSize;
  final Color color1;
  final Color color2;
  final Widget? child;

  const CheckeredPlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.squareSize = 10.0,
    this.color1 = const Color(0xFFE4E4E4),
    this.color2 = const Color(0xFFF4F4F4),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: CheckeredPainter(
          squareSize: squareSize,
          color1: color1,
          color2: color2,
        ),
        child: child,
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: content,
      );
    }
    return content;
  }
}

class CheckeredPainter extends CustomPainter {
  final double squareSize;
  final Color color1;
  final Color color2;

  const CheckeredPainter({
    this.squareSize = 10.0,
    this.color1 = const Color(0xFFE4E4E4),
    this.color2 = const Color(0xFFF4F4F4),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()..color = color1;
    final Paint paint2 = Paint()..color = color2;
    for (double i = 0; i < size.width; i += squareSize) {
      for (double j = 0; j < size.height; j += squareSize) {
        final bool even =
            ((i / squareSize).floor() + (j / squareSize).floor()) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(i, j, squareSize, squareSize),
          even ? paint1 : paint2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CheckeredPainter oldDelegate) =>
      oldDelegate.squareSize != squareSize ||
      oldDelegate.color1 != color1 ||
      oldDelegate.color2 != color2;
}
