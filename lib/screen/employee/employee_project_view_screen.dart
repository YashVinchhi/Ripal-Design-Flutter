import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/resource/app_navigation.dart';

class EmployeeProjectViewScreen extends StatefulWidget {
  const EmployeeProjectViewScreen({super.key});

  @override
  State<EmployeeProjectViewScreen> createState() => _EmployeeProjectViewScreenState();
}

class _EmployeeProjectViewScreenState extends State<EmployeeProjectViewScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _subTitleBrown = Color(0xFF9C5B43);

  int _currentIndex = 0;

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
            'Assigned Projects',
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
              'Active Work Assignments',
              style: TextStyle(
                color: _titleDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'View projects assigned to your team and monitor progress deadlines',
              style: TextStyle(
                color: _subTitleBrown,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),

            _buildProjectCard(
              title: 'Luxury Villa Design Phase 2',
              client: 'Apex Builders Pvt Ltd',
              progress: 0.75,
              deadline: 'Oct 30, 2026',
              tasks: '8 / 10 Tasks Completed',
              status: 'In Progress',
              statusColor: Colors.blue,
            ),
            _buildProjectCard(
              title: 'Urban High-Rise Office Tower',
              client: 'Skyline Infrastructures',
              progress: 0.40,
              deadline: 'Nov 15, 2026',
              tasks: '4 / 12 Tasks Completed',
              status: 'In Progress',
              statusColor: Colors.blue,
            ),
            _buildProjectCard(
              title: 'Eco Friendly Resort Layout',
              client: 'Green Spaces Hospitality',
              progress: 0.90,
              deadline: 'Oct 18, 2026',
              tasks: '18 / 20 Tasks Completed',
              status: 'Near Completion',
              statusColor: Colors.green,
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

  Widget _buildProjectCard({
    required String title,
    required String client,
    required double progress,
    required String deadline,
    required String tasks,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _titleDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Client: $client',
            style: const TextStyle(
              color: _subTitleBrown,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress: ${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                tasks,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFFBECEB),
              valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 6),
              Text(
                'Deadline: $deadline',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
