import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_history_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminLeaveScreen extends StatefulWidget {
  const AdminLeaveScreen({super.key});

  @override
  State<AdminLeaveScreen> createState() => _AdminLeaveScreenState();
}

class _AdminLeaveScreenState extends State<AdminLeaveScreen> {
  final Color primaryColor = const Color(0xFF5A0000);
  int _currentIndex = 1;

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      return;
    }
    if (index == 1) {
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
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Leave Management',
      appBarLeading: IconButton(
        icon: Icon(Icons.grid_view_outlined, color: primaryColor),
        onPressed: () {},
      ),
      appBarActions: [
        IconButton(
          icon: Icon(Icons.history, color: primaryColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminLeaveHistoryScreen()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 16,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
      },
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Metric cards
              _buildStatCard(
                title: 'Pending Requests',
                value: '5',
                badgeText: 'Urgent',
                badgeColor: const Color(0xFFF2D1CC),
                badgeTextColor: primaryColor,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                title: 'On Leave Today',
                value: '3',
                suffixText: ' / 20 total',
                bottomWidget: Row(
                  children: [
                    _buildAvatarPlaceholder(),
                    Transform.translate(offset: const Offset(-10, 0), child: _buildAvatarPlaceholder()),
                    Transform.translate(offset: const Offset(-20, 0), child: _buildAvatarPlaceholder()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                title: 'Available Staff',
                value: '12',
                badgeText: 'Optimal',
                badgeColor: const Color(0xFFD4F5E6),
                badgeTextColor: const Color(0xFF1E8F54),
                bottomWidget: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 16, color: Colors.black87),
                    const SizedBox(width: 4),
                    Text('Studio at 80% capacity', style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Priority Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLeaveHistoryScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.history, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text('Leave History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildLeaveRequestCard('Rachit Dudhaiya', 'Project Manager • Annual Leave', 'Oct 12 - Oct 15 (4 days)'),
              const SizedBox(height: 16),
              _buildLeaveRequestCard('Yash Vinchhi', 'Lead Architect • Wellness Day', 'Oct 18 (1 day)'),
              const SizedBox(height: 16),
              _buildLeaveRequestCard('Rajibul Sheikh', 'Designer • Annual Leave', 'Oct 20 - Oct 27 (8 days)'),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? suffixText,
    String? badgeText,
    Color? badgeColor,
    Color? badgeTextColor,
    Widget? bottomWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF2E6E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 0.5)),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: primaryColor)),
              if (suffixText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(suffixText, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                ),
              if (badgeText != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(16)),
                    child: Text(badgeText, style: TextStyle(color: badgeTextColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          if (bottomWidget != null) ...[
            const SizedBox(height: 16),
            bottomWidget,
          ],
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildLeaveRequestCard(String name, String roleInfo, String dateInfo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2E6E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 24, backgroundColor: Colors.grey.shade200),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(roleInfo, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 12, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(dateInfo, style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black26),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Reject', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: const Text('Approve', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
