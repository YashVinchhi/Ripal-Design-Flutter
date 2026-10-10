import 'package:flutter/material.dart';
import 'package:ripal_design/resource/widgets/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/controllers/role_guard.dart';
import 'package:ripal_design/resource/widgets/app_notification_icon.dart';
import 'package:ripal_design/service/leave_service.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker/worker_leave_request_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/worker/worker_upload_files_screen.dart';

class WorkerLeaveHistoryScreen extends StatefulWidget {
  final bool showBackButton;

  const WorkerLeaveHistoryScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<WorkerLeaveHistoryScreen> createState() => _WorkerLeaveHistoryScreenState();
}

class _WorkerLeaveHistoryScreenState extends State<WorkerLeaveHistoryScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);

  int _currentIndex = 1;
  List<LeaveRecord> _leaveRecords = [];
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
    final list = await LeaveService.getWorkerLeaves();
    if (mounted) {
      setState(() {
        _leaveRecords = list;
        _isLoading = false;
      });
    }
  }

  void _onNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
      return;
    }
    if (index == 1) {
      return; // Already here
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
      );
      return;
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkerLeaveRequestScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _leaveRecords.where((r) => r.status == 'PENDING').length;
    final approvedCount = _leaveRecords.where((r) => r.status == 'APPROVED').length;
    final remainingDays = (20 - approvedCount * 2).clamp(0, 30);

    return RoleGuardedScreen(
      allowedRoles: const ['worker', 'employee', 'admin'],
      child: Scaffold(
        backgroundColor: _bgCream,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: widget.showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: primaryColor),
                  onPressed: () => Navigator.pop(context),
                )
              : IconButton(
                  icon: const Icon(Icons.grid_view_outlined, color: primaryColor),
                  onPressed: () {},
                ),
          title: const Text(
            'Leave History',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          actions: const [
            AppNotificationIcon(),
            SizedBox(width: 8),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onFabPressed,
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          role: 'worker',
        ),
        body: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: primaryColor))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ─── Top 2 Stat Cards (matching Figma) ───────────────────
                      Row(
                        children: [
                          // Balance Card: Full dark maroon 2px border matching reference
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: primaryColor, width: 2.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'BALANCE',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Color(0xFF7A6666),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$remainingDays Days',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Pending Card
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFF2DED7), width: 1.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'PENDING',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Color(0xFF7A6666),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    pendingCount < 10 ? '0$pendingCount\nRequest' : '$pendingCount\nRequests',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF9E4723),
                                      height: 1.15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // ─── Section Header ─────────────────────────────────
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
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: _titleDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ─── Leave Records List ─────────────────────────────
                      if (_leaveRecords.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(
                            child: Text('No leave records found', style: TextStyle(color: Colors.grey)),
                          ),
                        )
                      else
                        ..._leaveRecords.map((record) => Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: _buildHistoryCard(record),
                            )),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(LeaveRecord record) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: record.status == 'PENDING' ? const Color(0xFFFFFDF5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: record.status == 'PENDING' ? const Color(0xFFFFECC2) : const Color(0xFFF2DED7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
              Text(
                record.appliedDate,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.grey.shade600,
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
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: record.statusColor,
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
              fontWeight: FontWeight.w800,
              color: _titleDark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Icon(record.icon, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${record.dateRange}  •  ${record.duration}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
