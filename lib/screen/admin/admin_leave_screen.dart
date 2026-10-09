import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/resource/app_navigation.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/service/leave_service.dart';
import 'package:ripal_design/screen/admin/admin_create_project.dart';
import 'package:ripal_design/screen/admin/admin_leave_history_screen.dart';

class AdminLeaveScreen extends StatefulWidget {
  const AdminLeaveScreen({super.key});

  @override
  State<AdminLeaveScreen> createState() => _AdminLeaveScreenState();
}

class _AdminLeaveScreenState extends State<AdminLeaveScreen> {
  final Color primaryColor = const Color(0xFF5A0000);
  final int _currentIndex = 1;
  List<LeaveRecord> _leaves = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeaves();
    LeaveService.leaveUpdateNotifier.addListener(_loadLeaves);
  }

  @override
  void dispose() {
    LeaveService.leaveUpdateNotifier.removeListener(_loadLeaves);
    super.dispose();
  }

  Future<void> _loadLeaves() async {
    final list = await LeaveService.getLeaves();
    if (mounted) {
      setState(() {
        _leaves = list;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleAction(String id, String name, String newStatus) async {
    await LeaveService.updateStatus(id, newStatus);
    await _loadLeaves();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(newStatus == 'APPROVED' ? 'Leave approved for $name' : 'Leave rejected for $name'),
          backgroundColor: newStatus == 'APPROVED' ? const Color(0xFF28854D) : primaryColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendingLeaves = _leaves.where((l) => l.status == 'PENDING').toList();
    final approvedLeaves = _leaves.where((l) => l.status == 'APPROVED').toList();

    return RoleGuardedScreen(
      allowedRoles: const ['admin', 'employee'],
      child: MainScaffold(
        appBarTitle: 'Leave Management',
        appBarLeading: IconButton(
          icon: Icon(Icons.grid_view_outlined, color: primaryColor),
          onPressed: () {},
        ),
        appBarActions: [
          IconButton(
            icon: Icon(Icons.history, color: primaryColor),
            tooltip: 'Leave History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminLeaveHistoryScreen()),
              );
            },
          ),
          const AppNotificationIcon(),
        ],
        currentIndex: _currentIndex,
        onNavTap: (index) => AppNavigation.handleNavTap(context, index, role: 'admin', currentIndex: _currentIndex),
        onFabPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
        },
        body: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Metric cards
                      _buildStatCard(
                        title: 'Pending Requests',
                        value: '${pendingLeaves.length}',
                        badgeText: pendingLeaves.isEmpty ? 'All Clear' : 'Urgent',
                        badgeColor: pendingLeaves.isEmpty ? const Color(0xFFD4F5E6) : const Color(0xFFF2D1CC),
                        badgeTextColor: pendingLeaves.isEmpty ? const Color(0xFF1E8F54) : primaryColor,
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        title: 'On Leave Today',
                        value: '${approvedLeaves.length}',
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
                        value: '${20 - approvedLeaves.length}',
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
                          Expanded(
                            child: Text(
                              'Priority Requests',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
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

                      if (pendingLeaves.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF2E6E3)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.check_circle_outline, size: 48, color: Colors.green.shade400),
                              const SizedBox(height: 12),
                              const Text('No Pending Requests', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('All leave requests have been processed.', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                            ],
                          ),
                        )
                      else
                        ...pendingLeaves.map((record) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: _buildLeaveRequestCard(record),
                            )),

                      const SizedBox(height: 40),
                    ],
                  ),
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2E6E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
              if (badgeText != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(badgeText, style: TextStyle(color: badgeTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
              if (suffixText != null)
                Text(suffixText, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
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

  Widget _buildLeaveRequestCard(LeaveRecord record) {
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
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFFDE9E6),
                child: Text(
                  record.applicantName.isNotEmpty ? record.applicantName[0].toUpperCase() : 'U',
                  style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: 18),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(record.applicantName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text('${record.applicantRole} • ${record.leaveType}', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 12, color: primaryColor),
                        const SizedBox(width: 4),
                        Text('${record.dateRange} (${record.duration})', style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w600)),
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
                  onPressed: () => _handleAction(record.id, record.applicantName, 'REJECTED'),
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
                  onPressed: () => _handleAction(record.id, record.applicantName, 'APPROVED'),
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
