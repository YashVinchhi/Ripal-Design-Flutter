import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String role; // 'admin', 'client', 'worker', 'employee'

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == 'admin';
    final isWorker = role == 'worker';
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: (isAdmin || isWorker) ? const Color(0xFFFFF7F2) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: (isAdmin || isWorker)
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
        border: (isAdmin || isWorker) ? Border.all(color: Colors.black12, width: 0.5) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(icon: items[0].icon, label: items[0].label, index: 0),
          _buildNavItem(icon: items[1].icon, label: items[1].label, index: 1),
          const SizedBox(width: 48), // Space for center FAB
          _buildNavItem(icon: items[2].icon, label: items[2].label, index: 2),
          _buildNavItem(icon: items[3].icon, label: items[3].label, index: 3),
        ],
      ),
    );
  }

  List<_NavItemData> _getNavItemsForRole(String role) {
    if (role == 'client') {
      // 1st Image: Client Navigation (Home, Project, FAB, Contact, Profile)
      return [
        const _NavItemData(icon: Icons.home_outlined, label: 'Home'),
        const _NavItemData(icon: Icons.grid_view_outlined, label: 'Project'),
        const _NavItemData(icon: Icons.description_outlined, label: 'Contact'),
        const _NavItemData(icon: Icons.person_outline, label: 'Profile'),
      ];
    } else if (role == 'worker') {
      // 2nd Image: Worker Navigation (Home, Leave, FAB, Upload, Profile)
      return [
        const _NavItemData(icon: Icons.home_outlined, label: 'Home'),
        const _NavItemData(icon: Icons.calendar_today_outlined, label: 'Leave'),
        const _NavItemData(icon: Icons.arrow_circle_up_outlined, label: 'Upload'),
        const _NavItemData(icon: Icons.person_outline, label: 'Profile'),
      ];
    } else if (role == 'employee') {
      // 3rd Image: Employee Navigation (Home, Leave, FAB, Upload, Profile)
      return [
        const _NavItemData(icon: Icons.home_outlined, label: 'Home'),
        const _NavItemData(icon: Icons.calendar_today_outlined, label: 'Leave'),
        const _NavItemData(icon: Icons.arrow_circle_up_outlined, label: 'Upload'),
        const _NavItemData(icon: Icons.person_outline, label: 'Profile'),
      ];
    } else {
      // 4th Image: Admin Navigation (Home, Leave, FAB, Finance, Settings)
      return [
        const _NavItemData(icon: Icons.home_outlined, label: 'Home'),
        const _NavItemData(icon: Icons.calendar_today_outlined, label: 'Leave'),
        const _NavItemData(icon: Icons.payments_outlined, label: 'Finance'),
        const _NavItemData(icon: Icons.settings_outlined, label: 'Settings'),
      ];
    }
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected
        ? const Color(0xFF5A0000)
        : Colors.grey.shade500;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}

