import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/workflow_stepper.dart';
import '../data/mock_data.dart';
import '../models/activity_model.dart';
import '../routes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: -1),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Back Arrow and S I T E   L O G
                AppHeader(
                  title: 'S I T E   L O G',
                  showBack: true,
                  showAvatar: true,
                  onAvatarTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 4),

                // 2. Workflow Stepper (Step 4 Active)
                const WorkflowStepper(activeStep: 4),

                const SizedBox(height: 12),

                // 3. Activity Feed Headline with Underline
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ACTIVITY FEED', style: AppTypography.kicker),
                      const SizedBox(height: 4),
                      Text(
                        'Live Construction Log',
                        style: AppTypography.largeTitle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 48,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 4. Activity Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: MockData.siteActivities.map((activity) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon Box
                            _buildActivityIcon(activity.type),
                            const SizedBox(width: 14),

                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity.title,
                                    style: AppTypography.cardTitle.copyWith(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (activity.subtitle != null) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      activity.subtitle!,
                                      style: AppTypography.cardSubtitle.copyWith(
                                        fontSize: 13,
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 6),
                                  Text(
                                    activity.timestamp,
                                    style: AppTypography.cardSubtitle.copyWith(
                                      fontSize: 11.5,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  if (activity.progressPercentage != null) ...[
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: LinearProgressIndicator(
                                        value: (activity.progressPercentage! / 100),
                                        minHeight: 4,
                                        backgroundColor: const Color(0xFFF2EAE7),
                                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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

  Widget _buildActivityIcon(ActivityType type) {
    IconData iconData;
    Color bgColor = AppColors.surfaceSecondary;
    Color iconColor = AppColors.primary;

    switch (type) {
      case ActivityType.file:
        iconData = Icons.file_upload_outlined;
        break;
      case ActivityType.progress:
        iconData = Icons.sync_rounded;
        break;
      case ActivityType.member:
        iconData = Icons.person_add_alt_1_outlined;
        break;
      case ActivityType.milestone:
        iconData = Icons.flag;
        bgColor = AppColors.primary;
        iconColor = Colors.white;
        break;
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }
}
