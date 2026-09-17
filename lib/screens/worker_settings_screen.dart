import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../routes.dart';

class WorkerSettingsScreen extends StatefulWidget {
  const WorkerSettingsScreen({super.key});

  @override
  State<WorkerSettingsScreen> createState() => _WorkerSettingsScreenState();
}

class _WorkerSettingsScreenState extends State<WorkerSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailReports = false;

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: const RipalBottomNavBar(currentIndex: 3),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Header
                AppHeader(
                  title: 'Settings',
                  showClose: true,
                  showAvatar: true,
                  onBack: () => Navigator.of(context).maybePop(),
                ),

                const SizedBox(height: 12),

                // 2. Profile Avatar with Edit Pencil
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.uploadProfilePhoto);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFF0E5E2), width: 3),
                                color: AppColors.surfaceSecondary,
                              ),
                              child: ClipOval(
                                child: CustomPaint(
                                  painter: AvatarPatternPainter(),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Your Name',
                        style: AppTypography.cardTitle.copyWith(fontSize: 19),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'youremail@example.com',
                        style: AppTypography.cardSubtitle,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // 3. ACCOUNT Group
                _buildSectionKicker('ACCOUNT'),
                _buildCardContainer([
                  _buildListRow(
                    icon: Icons.person_outline_rounded,
                    title: 'Profile Information',
                    showChevron: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.editProfile);
                    },
                  ),
                  const Divider(height: 1),
                  _buildListRow(
                    icon: Icons.shield_outlined,
                    title: 'Security & Password',
                    showChevron: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.securitySettings);
                    },
                  ),
                ]),

                const SizedBox(height: 22),

                // 4. NOTIFICATIONS Group
                _buildSectionKicker('NOTIFICATIONS'),
                _buildCardContainer([
                  _buildListRow(
                    icon: Icons.notifications_none_rounded,
                    title: 'Push Notifications',
                    subtitle: 'Alerts, updates and activities',
                    trailing: Switch(
                      value: _pushNotifications,
                      onChanged: (val) {
                        setState(() => _pushNotifications = val);
                      },
                      activeThumbColor: AppColors.primary,
                      activeTrackColor: AppColors.primary.withValues(alpha: 0.35),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppColors.border,
                    ),
                  ),
                  const Divider(height: 1),
                  _buildListRow(
                    icon: Icons.mail_outline_rounded,
                    title: 'Email Reports',
                    subtitle: 'Weekly summaries and news',
                    trailing: Switch(
                      value: _emailReports,
                      onChanged: (val) {
                        setState(() => _emailReports = val);
                      },
                      activeThumbColor: AppColors.primary,
                      activeTrackColor: AppColors.primary.withValues(alpha: 0.35),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppColors.border,
                    ),
                  ),
                ]),

                const SizedBox(height: 22),

                // 5. PREFERENCES Group
                _buildSectionKicker('PREFERENCES'),
                _buildCardContainer([
                  _buildListRow(
                    icon: Icons.language_rounded,
                    title: 'Language',
                    subtitle: 'English (US)',
                    showChevron: true,
                  ),
                  const Divider(height: 1),
                  _buildListRow(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: 'Light Mode',
                    showChevron: true,
                  ),
                ]),

                const SizedBox(height: 22),

                // 6. SUPPORT Group
                _buildSectionKicker('SUPPORT'),
                _buildCardContainer([
                  _buildListRow(
                    icon: Icons.help_outline_rounded,
                    title: 'Help Center',
                    showChevron: true,
                  ),
                  const Divider(height: 1),
                  _buildListRow(
                    icon: Icons.alternate_email_rounded,
                    title: 'Privacy Policy',
                    showChevron: true,
                  ),
                  const Divider(height: 1),
                  _buildListRow(
                    icon: Icons.info_outline_rounded,
                    title: 'App Version',
                    trailing: Text(
                      'v0.0.1',
                      style: AppTypography.cardSubtitle.copyWith(fontSize: 13),
                    ),
                  ),
                ]),

                const SizedBox(height: 28),

                // 7. Log Out Action
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.dashboard,
                            (route) => false,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout_rounded, color: AppColors.textPrimary, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Log Out',
                                style: AppTypography.buttonText.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 14.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Logged in as yourname',
                        style: AppTypography.cardSubtitle.copyWith(fontSize: 12),
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

  Widget _buildSectionKicker(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 8),
      child: Text(title, style: AppTypography.kicker),
    );
  }

  Widget _buildCardContainer(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildListRow({
    required IconData icon,
    required String title,
    String? subtitle,
    bool showChevron = false,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textPrimary, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.cardTitle.copyWith(fontSize: 14.5, fontWeight: FontWeight.w600),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.cardSubtitle.copyWith(fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
            ?trailing,
            if (showChevron)
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}
