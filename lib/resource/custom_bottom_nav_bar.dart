import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String role; // 'admin' or 'client'

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == 'admin';
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: isAdmin ? const Color(0xFFFFF7F2) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: isAdmin
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
        border: isAdmin ? Border.all(color: Colors.black12, width: 0.5) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(icon: Icons.home_outlined, label: 'Home', index: 0),
          _buildNavItem(
            icon: isAdmin ? Icons.calendar_today_outlined : Icons.grid_view_outlined,
            label: isAdmin ? 'Leave' : 'Project',
            index: 1,
          ),
          const SizedBox(width: 48), // Space for FAB
          _buildNavItem(
            icon: isAdmin ? Icons.money_outlined : Icons.description_outlined,
            label: isAdmin ? 'Finance' : 'Contact',
            index: 2,
          ),
          _buildNavItem(
            icon: isAdmin ? Icons.settings_outlined : Icons.person_outline,
            label: isAdmin ? 'Settings' : 'Profile',
            index: 3,
          ),
        ],
      ),
    );
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
