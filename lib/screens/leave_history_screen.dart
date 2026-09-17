import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge.dart';
import '../data/mock_data.dart';
import '../routes.dart';

class LeaveHistoryScreen extends StatelessWidget {
  const LeaveHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 1),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header with Logo and Avatar
                AppHeader(
                  title: 'Leave History',
                  showLogo: true,
                  showAvatar: true,
                  onAvatarTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                ),

                const SizedBox(height: 10),

                // 2. Top Stats Cards (Balance & Pending)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Balance Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primary, width: 1.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BALANCE', style: AppTypography.kicker),
                              const SizedBox(height: 6),
                              Text(
                                '12 Days',
                                style: AppTypography.largeTitle.copyWith(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Pending Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PENDING', style: AppTypography.kicker),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '01\n',
                                      style: AppTypography.largeTitle.copyWith(
                                        fontSize: 22,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Request',
                                      style: AppTypography.cardSubtitle.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. Section Header: "| Request History"
                const SectionHeader(
                  title: 'Request History',
                  showPrefixBar: true,
                ),

                const SizedBox(height: 6),

                // 4. Request History Cards List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: MockData.leaveHistory.map((leave) {
                      IconData typeIcon = Icons.calendar_today_outlined;
                      if (leave.type.contains('Wellness')) {
                        typeIcon = Icons.spa_outlined;
                      } else if (leave.type.contains('Conference')) {
                        typeIcon = Icons.event_busy_outlined;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  leave.requestDate,
                                  style: AppTypography.kicker.copyWith(
                                    fontSize: 11,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                StatusBadge.fromLeaveStatus(leave.status),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              leave.type,
                              style: AppTypography.cardTitle.copyWith(fontSize: 17, height: 1.2),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(typeIcon, size: 16, color: AppColors.textSecondary),
                                const SizedBox(width: 8),
                                Text(
                                  '${leave.dateRange}  •  ${leave.durationText}',
                                  style: AppTypography.cardSubtitle.copyWith(fontSize: 12.5),
                                ),
                              ],
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
}
