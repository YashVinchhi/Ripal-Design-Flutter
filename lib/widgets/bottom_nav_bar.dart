import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../routes.dart';

class RipalBottomNavBar extends StatelessWidget {
  final int currentIndex; // 0: Home, 1: Leave, 2: Upload, 3: Profile, -1: None
  final Function(int)? onTap;

  const RipalBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  void _handleNavigation(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
        break;
      case 1:
        Navigator.of(context).pushNamed(AppRoutes.leaveHistory);
        break;
      case 2:
        Navigator.of(context).pushNamed(AppRoutes.uploadFiles);
        break;
      case 3:
        Navigator.of(context).pushNamed(AppRoutes.settings);
        break;
    }
  }

  void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Quick Actions', style: AppTypography.sectionTitle),
              const SizedBox(height: 16),
              _modalActionItem(
                context,
                icon: Icons.edit_calendar_outlined,
                title: 'Apply for Leave',
                subtitle: 'Submit a new absence or wellness request',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushNamed(AppRoutes.leaveRequest);
                },
              ),
              const Divider(height: 20),
              _modalActionItem(
                context,
                icon: Icons.cloud_upload_outlined,
                title: 'Upload Project Blueprints',
                subtitle: 'Add CAD, DWG or PDF documentation',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushNamed(AppRoutes.uploadFiles);
                },
              ),
              const Divider(height: 20),
              _modalActionItem(
                context,
                icon: Icons.assignment_outlined,
                title: 'View Project Details',
                subtitle: 'Open Obsidian House construction phases',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushNamed(AppRoutes.projectView);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _modalActionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.cardSubtitle.copyWith(fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1. Home
              _buildNavItem(
                context: context,
                index: 0,
                icon: Icons.storefront_outlined,
                label: 'Home',
              ),

              // 2. Leave
              _buildNavItem(
                context: context,
                index: 1,
                icon: Icons.calendar_today_outlined,
                label: 'Leave',
              ),

              // 3. Center Floating Plus Button
              _buildFloatingCenterButton(context),

              // 4. Upload
              _buildNavItem(
                context: context,
                index: 2,
                icon: Icons.arrow_circle_up_outlined,
                label: 'Upload',
              ),

              // 5. Profile
              _buildNavItem(
                context: context,
                index: 3,
                icon: Icons.account_circle_outlined,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = currentIndex == index;
    final Color itemColor = isSelected ? AppColors.navActive : AppColors.navInactive;

    return InkWell(
      onTap: () => _handleNavigation(context, index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: itemColor,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.navLabel.copyWith(
                color: itemColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCenterButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddModal(context),
      child: Container(
        width: 46,
        height: 46,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.28),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
