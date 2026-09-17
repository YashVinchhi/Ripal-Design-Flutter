import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/statistic_card.dart';
import '../widgets/project_card.dart';
import '../widgets/quick_action_card.dart';
import '../data/mock_data.dart';
import '../routes.dart';

class WorkerDashboardScreen extends StatelessWidget {
  const WorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 0),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Header
                AppHeader(
                  title: 'Ripal Design',
                  showLogo: true,
                  showNotification: true,
                  showAvatar: true,
                  onNotificationTap: () {
                    Navigator.pushNamed(context, AppRoutes.activity);
                  },
                  onAvatarTap: () {
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),

                const SizedBox(height: 12),

                // 2. Greeting Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'D A S H B O A R D   O V E R V I E W',
                        style: AppTypography.kicker,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Welcome, Rachit',
                        style: AppTypography.largeTitle,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: AppTypography.bodyText,
                          children: const [
                            TextSpan(text: 'You have '),
                            TextSpan(
                              text: '12 Active Projects\n',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(text: 'requiring your attention today.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Statistics Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Active Projects Card
                      const StatisticCard(
                        label: 'ACTIVE PROJECTS',
                        value: '15',
                        icon: Icons.person_outline_rounded,
                        iconBg: AppColors.personBadgeBg,
                        iconColor: AppColors.personBadgeIcon,
                      ),
                      const SizedBox(height: 14),

                      // Team Velocity Card
                      const StatisticCard(
                        label: 'TEAM VELOCITY',
                        value: '30',
                        icon: Icons.people_outline_rounded,
                        iconBg: AppColors.velocityBadgeBg,
                        iconColor: AppColors.velocityBadgeIcon,
                        badgeText: '8 New',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 4. Assigned Projects Carousel
                SectionHeader(
                  title: 'Assigned Projects',
                  actionText: 'EXPLORE PROJECTS →',
                  onActionTap: () {
                    Navigator.pushNamed(context, AppRoutes.projectView);
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 235,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: MockData.assignedProjects.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final project = MockData.assignedProjects[index];
                      return ProjectCard(
                        project: project,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.projectView);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // 5. Quick Actions Section (2x3 Grid)
                const SectionHeader(
                  title: 'Quick Actions',
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: QuickActionCard(
                              icon: Icons.remove_red_eye_outlined,
                              label: 'VIEW PROJECT',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.projectView);
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: QuickActionCard(
                              icon: Icons.cloud_upload_outlined,
                              label: 'UPLOAD FILES',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.uploadFiles);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: QuickActionCard(
                              icon: Icons.person_outline_rounded,
                              label: 'TEAM VIEW',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.executionCrew);
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: QuickActionCard(
                              icon: Icons.description_outlined,
                              label: 'FILE VIEWS',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.projectFiles);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: QuickActionCard(
                              icon: Icons.edit_calendar_outlined,
                              label: 'LEAVE MANGE',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.leaveHistory);
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: QuickActionCard(
                              icon: Icons.timeline_rounded,
                              label: 'ACTIVITY',
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.activity);
                              },
                            ),
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
