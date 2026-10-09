import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/resource/app_navigation.dart';

class EmployeeLeaveHistoryScreen extends StatefulWidget {
  const EmployeeLeaveHistoryScreen({super.key});

  @override
  State<EmployeeLeaveHistoryScreen> createState() => _EmployeeLeaveHistoryScreenState();
}

class _EmployeeLeaveHistoryScreenState extends State<EmployeeLeaveHistoryScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _subTitleBrown = Color(0xFF9C5B43);

  int _currentIndex = 1;

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
            'Leave Requests & History',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
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
            // Leave Summary Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0E0D9)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryCol('Casual Leave', '8 / 12', Colors.blue),
                  Container(height: 36, width: 1, color: Colors.grey.shade300),
                  _buildSummaryCol('Sick Leave', '4 / 7', Colors.orange),
                  Container(height: 36, width: 1, color: Colors.grey.shade300),
                  _buildSummaryCol('Earned Leave', '2 / 5', Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Leave Requests',
                  style: TextStyle(
                    color: _titleDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('New Leave Request feature submitted to Manager.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18, color: Colors.white),
                  label: const Text('Apply Leave', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _buildLeaveTile(
              type: 'Casual Leave',
              dates: 'Oct 15 - Oct 17 (3 Days)',
              reason: 'Personal family event',
              status: 'Approved',
              statusColor: Colors.green,
            ),
            _buildLeaveTile(
              type: 'Sick Leave',
              dates: 'Sep 02 - Sep 03 (2 Days)',
              reason: 'Medical checkup and recovery',
              status: 'Approved',
              statusColor: Colors.green,
            ),
            _buildLeaveTile(
              type: 'Earned Leave',
              dates: 'Nov 01 - Nov 05 (5 Days)',
              reason: 'Annual vacation',
              status: 'Pending',
              statusColor: Colors.orange,
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

  Widget _buildSummaryCol(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: _subTitleBrown,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveTile({
    required String type,
    required String dates,
    required String reason,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0E0D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: _titleDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            dates,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            reason,
            style: const TextStyle(
              color: _subTitleBrown,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
