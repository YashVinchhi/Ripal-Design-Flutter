import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/resource/app_navigation.dart';

class EmployeeActivityScreen extends StatefulWidget {
  const EmployeeActivityScreen({super.key});

  @override
  State<EmployeeActivityScreen> createState() => _EmployeeActivityScreenState();
}

class _EmployeeActivityScreenState extends State<EmployeeActivityScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _subTitleBrown = Color(0xFF9C5B43);

  int _currentIndex = 2;

  void _onNavTap(int index) {
    AppNavigation.handleNavTap(
      context,
      index,
      role: 'employee',
      currentIndex: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuardedScreen(
      allowedRoles: const ['employee', 'admin'],
      child: Scaffold(
        backgroundColor: _bgCream,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            'Employee Activity',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: const [
            AppNotificationIcon(),
            SizedBox(width: 16),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Activity & Log History',
              style: TextStyle(
                color: _titleDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Track your daily contributions, submitted files, and team updates',
              style: TextStyle(
                color: _subTitleBrown,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            _buildLogCard(
              title: 'Floor Plan Revision Uploaded',
              details: 'Uploaded updated floor plan v3 for Commercial Complex Project.',
              timestamp: 'Today, 10:45 AM',
              icon: Icons.cloud_upload_outlined,
              badgeColor: Colors.blue,
            ),
            _buildLogCard(
              title: 'Site Visit Completed',
              details: 'Logged site inspection notes and structural photos.',
              timestamp: 'Yesterday, 3:30 PM',
              icon: Icons.location_on_outlined,
              badgeColor: Colors.green,
            ),
            _buildLogCard(
              title: 'Material List Approved',
              details: 'Steel and concrete estimate sheets validated.',
              timestamp: 'Oct 07, 2026',
              icon: Icons.fact_check_outlined,
              badgeColor: Colors.orange,
            ),
            _buildLogCard(
              title: 'Team Sync Meeting',
              details: 'Attended weekly architectural sync with Senior Architect.',
              timestamp: 'Oct 05, 2026',
              icon: Icons.groups_outlined,
              badgeColor: Colors.purple,
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          role: 'employee',
        ),
      ),
    );
  }

  Widget _buildLogCard({
    required String title,
    required String details,
    required String timestamp,
    required IconData icon,
    required Color badgeColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0E0D9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: badgeColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _titleDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    color: _subTitleBrown,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  timestamp,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
