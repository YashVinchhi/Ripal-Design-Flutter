import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/resource/app_navigation.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/service/leave_service.dart';
import 'package:ripal_design/screen/admin_create_project.dart';

class AdminLeaveHistoryScreen extends StatefulWidget {
  const AdminLeaveHistoryScreen({super.key});

  @override
  State<AdminLeaveHistoryScreen> createState() => _AdminLeaveHistoryScreenState();
}

class _AdminLeaveHistoryScreenState extends State<AdminLeaveHistoryScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);

  final int _currentIndex = 1;
  List<LeaveRecord> _leaveHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    LeaveService.leaveUpdateNotifier.addListener(_loadHistory);
  }

  @override
  void dispose() {
    LeaveService.leaveUpdateNotifier.removeListener(_loadHistory);
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final list = await LeaveService.getLeaves();
    if (mounted) {
      setState(() {
        _leaveHistory = list;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _leaveHistory.where((l) => l.status == 'PENDING').length;

    return RoleGuardedScreen(
      allowedRoles: const ['admin', 'employee'],
      child: MainScaffold(
        currentIndex: _currentIndex,
        onNavTap: (index) => AppNavigation.handleNavTap(context, index, currentIndex: _currentIndex),
        onFabPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
        },
        appBarTitle: 'Leave History',
        appBarLeading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        appBarActions: const [
          AppNotificationIcon(),
        ],
        body: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: primaryColor))
              : SingleChildScrollView(
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
                              value: pendingCount < 10 ? '0$pendingCount Requests' : '$pendingCount Requests',
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
                      if (_leaveHistory.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(
                            child: Text('No leave records found', style: TextStyle(color: Colors.grey)),
                          ),
                        )
                      else
                        ..._leaveHistory.map((record) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: _buildHistoryCard(record),
                            )),
                      const SizedBox(height: 40),
                    ],
                  ),
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

  Widget _buildHistoryCard(LeaveRecord record) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: record.status == 'PENDING' ? const Color(0xFFFFFDF5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: record.status == 'PENDING' ? const Color(0xFFFFECC2) : const Color(0xFFE5CCC9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${record.appliedDate} • ${record.applicantName}',
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
                  color: record.statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record.status,
                  style: TextStyle(
                    color: record.statusColor,
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
            record.leaveType,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _titleDark,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Icon(record.icon, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Text(
                '${record.dateRange}  •  ${record.duration}',
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
