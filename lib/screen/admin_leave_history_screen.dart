import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminLeaveHistoryScreen extends StatefulWidget {
  const AdminLeaveHistoryScreen({super.key});

  @override
  State<AdminLeaveHistoryScreen> createState() => _AdminLeaveHistoryScreenState();
}

class _AdminLeaveHistoryScreenState extends State<AdminLeaveHistoryScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);

  int _currentIndex = 1;

  final List<Map<String, dynamic>> _leaveHistory = [
    {
      'appliedDate': 'SEP 04, 2024',
      'title': 'Annual Leave',
      'dateRange': '10-24 Oct',
      'duration': '2 weeks',
      'status': 'APPROVED',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'appliedDate': 'AUG 12, 2024',
      'title': 'Wellness Day',
      'dateRange': 'Aug 15',
      'duration': '1 day',
      'status': 'APPROVED',
      'icon': Icons.spa_outlined,
    },
    {
      'appliedDate': 'JUL 20, 2024',
      'title': 'Annual Leave',
      'dateRange': 'Jul 22-23',
      'duration': '2 days',
      'status': 'PENDING',
      'icon': Icons.calendar_today_outlined,
    },
    {
      'appliedDate': 'MAY 15, 2024',
      'title': 'Conference',
      'dateRange': 'May 18-20',
      'duration': '3 days',
      'status': 'REJECTED',
      'icon': Icons.event_outlined,
    },
    {
      'appliedDate': 'APR 02, 2024',
      'title': 'Annual Leave',
      'dateRange': 'Apr 10-15',
      'duration': '4 days',
      'status': 'APPROVED',
      'icon': Icons.calendar_today_outlined,
    },
  ];

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      return;
    }
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminLeaveScreen()));
      return;
    }
    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
      return;
    }
    if (index == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: 'Leave History',
      appBarLeading: IconButton(
        icon: const Icon(Icons.arrow_back, color: primaryColor),
        onPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Metric Cards Row (BALANCE & PENDING)
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      label: 'BALANCE',
                      value: '12 Days',
                      valueColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      label: 'PENDING',
                      value: '01 Request',
                      valueColor: const Color(0xFF9E4723),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Request History Header
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 20,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Request History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _titleDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Request History List Items
              ..._leaveHistory.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildHistoryCard(item),
                  )),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5CCC9)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 3,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    final String status = item['status'] as String;
    Color statusBg = const Color(0xFFE2F7ED);
    Color statusFg = const Color(0xFF1E8F54);

    if (status == 'PENDING') {
      statusBg = const Color(0xFFFFF3D6);
      statusFg = const Color(0xFFB88200);
    } else if (status == 'REJECTED') {
      statusBg = const Color(0xFFFDE2E2);
      statusFg = const Color(0xFFE53935);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: status == 'PENDING' ? const Color(0xFFFFFDF5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: status == 'PENDING' ? const Color(0xFFFFECC2) : const Color(0xFFE5CCC9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['appliedDate'] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusFg,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            item['title'] as String,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _titleDark,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Icon(item['icon'] as IconData, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Text(
                '${item['dateRange']}  •  ${item['duration']}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
