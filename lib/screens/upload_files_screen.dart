import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/workflow_stepper.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import '../routes.dart';

class UploadFilesScreen extends StatefulWidget {
  const UploadFilesScreen({super.key});

  @override
  State<UploadFilesScreen> createState() => _UploadFilesScreenState();
}

class _UploadFilesScreenState extends State<UploadFilesScreen> {
  final List<Map<String, dynamic>> _files = [
    {
      'name': 'Modernist_Villa_Phase_01.dwg',
      'icon': Icons.description_outlined,
      'progress': 0.82,
    },
    {
      'name': 'Material_Swatches_HD.zip',
      'icon': Icons.image_outlined,
      'progress': 0.45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 2),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Back Arrow
                AppHeader(
                  title: 'Upload Files',
                  showBack: true,
                  showAvatar: false,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 4),

                // 2. Workflow Stepper (Step 3 Active)
                const WorkflowStepper(activeStep: 3),

                const SizedBox(height: 12),

                // 3. Headline & Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submit\nBlueprints',
                        style: AppTypography.largeTitle.copyWith(fontSize: 28, height: 1.15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add new project files to your architectural\narchive. Supports DWG, PDF, and high-resolution CAD exports.',
                        style: AppTypography.bodyText,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // 4. Dashed Drop Box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomPaint(
                    painter: DashedBorderPainter(
                      color: const Color(0xFFD4C2BD),
                      strokeWidth: 1.5,
                      dashPattern: const [6, 4],
                      radius: 16,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSecondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.file_upload_outlined,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Drop files here or\nbrowse',
                            textAlign: TextAlign.center,
                            style: AppTypography.cardTitle.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Upload CAD files,\nsketches, or high-res\nmood boards. Max size\n100MB.',
                            textAlign: TextAlign.center,
                            style: AppTypography.cardSubtitle.copyWith(fontSize: 12.5),
                          ),
                          const SizedBox(height: 20),

                          // Select Project Files button
                          PrimaryButton(
                            text: 'Select\nProject Files',
                            height: 48,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('File picker opened. Select blueprint or CAD files.'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),

                          // View Project Files button
                          PrimaryButton(
                            text: 'View\nProject Files',
                            height: 48,
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.projectFiles);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                // 5. Active Syncing Section Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active Syncing',
                        style: AppTypography.sectionTitle.copyWith(fontSize: 16),
                      ),
                      Text(
                        '${_files.length} FILES REMAINING',
                        style: AppTypography.kicker.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 6. Syncing Files Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: _files.map((file) {
                      final double progress = file['progress'];
                      final int percent = (progress * 100).toInt();

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  file['icon'] as IconData,
                                  color: AppColors.primary,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    file['name'] as String,
                                    style: AppTypography.cardTitle.copyWith(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _files.remove(file);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 4,
                                      backgroundColor: const Color(0xFFF2EAE7),
                                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '$percent%',
                                  style: AppTypography.cardSubtitle.copyWith(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // 7. Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SecondaryButton(
                        text: 'Save Draft',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Draft saved successfully!'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        text: 'Next →',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.activity);
                        },
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info_outline, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            'Draft saved automatically at 14:02',
                            style: AppTypography.cardSubtitle.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double radius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = _createDashedPath(path, dashPattern);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, List<double> dashPattern) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      int index = 0;
      while (distance < metric.length) {
        final length = dashPattern[index % dashPattern.length];
        if (index % 2 == 0) {
          dest.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        index++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
