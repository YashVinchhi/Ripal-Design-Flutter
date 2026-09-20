import 'package:flutter/material.dart';

/// A Pinterest-style project card with a variable height placeholder image,
/// dark gradient overlay, and project name + category at the bottom.
class ProjectCard extends StatelessWidget {
  final String name;
  final String category;
  final String year;
  final double height; // Variable height for masonry effect
  final String? imageUrl;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.name,
    required this.category,
    required this.year,
    required this.height,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image / checkered placeholder
              imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),

              // Bottom gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.40, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.78),
                      ],
                    ),
                  ),
                ),
              ),

              // Text overlay at bottom
              Positioned(
                left: 12,
                right: 8,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$category • $year',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.72),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return CustomPaint(painter: _CheckeredPainter());
  }
}

class _CheckeredPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()..color = const Color(0xFFD0D0D0);
    final Paint paint2 = Paint()..color = const Color(0xFFE8E8E8);
    const double sq = 10.0;
    for (double i = 0; i < size.width; i += sq) {
      for (double j = 0; j < size.height; j += sq) {
        final bool even = ((i / sq).floor() + (j / sq).floor()) % 2 == 0;
        canvas.drawRect(Rect.fromLTWH(i, j, sq, sq), even ? paint1 : paint2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
