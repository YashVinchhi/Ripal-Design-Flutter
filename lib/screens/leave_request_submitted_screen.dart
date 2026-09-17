import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import '../routes.dart';

class LeaveRequestSubmittedScreen extends StatelessWidget {
  const LeaveRequestSubmittedScreen({super.key});

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
                  title: 'Leave Requset',
                  showLogo: true,
                  showAvatar: true,
                  onAvatarTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                ),

                const SizedBox(height: 36),

                // 2. Big Circular Checkmark Badge
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Request Submitted',
                        style: AppTypography.largeTitle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTypography.bodyText.copyWith(height: 1.45),
                            children: const [
                              TextSpan(text: 'Your leave request for '),
                              TextSpan(
                                text: 'Annual Leave\n(Oct 10 - Oct 24) ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              TextSpan(
                                text: 'has been successfully\nsent to your manager for approval.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // 3. Current Status Card (Pending Approval with dots)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Column(
                      children: [
                        Text('CURRENT STATUS', style: AppTypography.kicker),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.edit_calendar_outlined,
                              color: Color(0xFF8B2500),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Pending Approval',
                              style: AppTypography.cardTitle.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _statusDot(const Color(0xFFF0A8A8)),
                            const SizedBox(width: 6),
                            _statusDot(const Color(0xFFE89090)),
                            const SizedBox(width: 6),
                            _statusDot(const Color(0xFFF5D0D0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // 4. Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      PrimaryButton(
                        text: 'Back to Dashboard',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.dashboard,
                            (route) => false,
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      SecondaryButton(
                        text: 'View My Requests',
                        backgroundColor: AppColors.surfaceSecondary,
                        textColor: AppColors.primary,
                        borderColor: AppColors.border,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.leaveHistory);
                        },
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

  Widget _statusDot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
