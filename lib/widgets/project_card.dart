import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final int percentInt = (project.progress * 100).toInt();
    final bool isReview = project.statusBadge.toUpperCase() == 'REVIEW';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 265,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with Architectural Pattern & Status Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Container(
                    height: 130,
                    width: double.infinity,
                    color: const Color(0xFFF6F0ED),
                    child: CustomPaint(
                      painter: BlueprintGridPainter(),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: isReview ? AppColors.badgeReview : AppColors.badgeActive,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      project.statusBadge.toUpperCase(),
                      style: AppTypography.badge.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            // Card Details
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: AppTypography.cardTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '$percentInt% Done',
                        style: AppTypography.cardSubtitle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.phase,
                    style: AppTypography.cardSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: project.progress,
                      minHeight: 4,
                      backgroundColor: const Color(0xFFF2EAE7),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg1 = Paint()..color = const Color(0xFFF8F3F0);
    final bg2 = Paint()..color = const Color(0xFFEDE5E1);
    final double step = 20;

    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        final isEven = ((x / step).toInt() + (y / step).toInt()) % 2 == 0;
        canvas.drawRect(Rect.fromLTWH(x, y, step, step), isEven ? bg1 : bg2);
      }
    }

    // Subtle isometric architectural lines
    final linePaint = Paint()
      ..color = const Color(0x187A0F0F)
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.3),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, size.height),
      Offset(size.width * 0.8, 0),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
