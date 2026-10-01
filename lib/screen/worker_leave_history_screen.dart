import 'package:flutter/material.dart';
import 'package:ripal_design/resource/checkered_placeholder.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker_leave_request_screen.dart';
import 'package:ripal_design/screen/worker_settings_screen.dart';
import 'package:ripal_design/screen/worker_upload_files_screen.dart';

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

  final List<Map<String, dynamic>> _leaveRecords = [
    {
      'date': 'SEP 04, 2024',
      'title': 'Annual\nLeave',
      'duration': 'Oct 10-15  •  2 weeks',
      'status': 'APPROVED',
      'statusBg': const Color(0xFFE5F7ED),
      'statusColor': const Color(0xFF28854D),
      'icon': Icons.calendar_today_outlined,
    },
    {
      'date': 'AUG 12, 2024',
      'title': 'Wellness\nDay',
      'duration': 'Aug 15  •  1 day',
      'status': 'APPROVED',
      'statusBg': const Color(0xFFE5F7ED),
      'statusColor': const Color(0xFF28854D),
      'icon': Icons.spa_outlined,
    },
    {
      'date': 'JUL 20, 2024',
      'title': 'Annual\nLeave',
      'duration': 'Jul 22-23  •  2 days',
      'status': 'PENDING',
      'statusBg': const Color(0xFFFEF3D6),
      'statusColor': const Color(0xFFB57D18),
      'icon': Icons.calendar_today_outlined,
    },
    {
      'date': 'MAY 15, 2024',
      'title': 'Conference',
      'duration': 'May 18-20  •  3 days',
      'status': 'REJECTED',
      'statusBg': const Color(0xFFFDE8E8),
      'statusColor': const Color(0xFFC53030),
      'icon': Icons.event_note_outlined,
    },
    {
      'date': 'APR 02, 2024',
      'title': 'Annual\nLeave',
      'duration': 'Apr 10-15  •  4 days',
      'status': 'APPROVED',
      'statusBg': const Color(0xFFE5F7ED),
      'statusColor': const Color(0xFF28854D),
      'icon': Icons.calendar_today_outlined,
    },
  ];

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
        MaterialPageRoute(builder: (context) => const WorkerSettingsScreen()),
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
    return Scaffold(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2C4BD), width: 1),
              ),
              child: const ClipOval(
                child: CheckeredPlaceholder(squareSize: 4),
              ),
            ),
          ),
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Top 2 Stat Cards ──────────────────────────────
                  Row(
                    children: [
                      // Balance Card with dark maroon left-bottom border
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(8),
                            ),
                            border: const Border(
                              left: BorderSide(color: primaryColor, width: 2.5),
                              bottom: BorderSide(color: primaryColor, width: 2.5),
                              top: BorderSide(color: Color(0xFFF2DED7), width: 1),
                              right: BorderSide(color: Color(0xFFF2DED7), width: 1),
                            ),
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
                            children: const [
                              Text(
                                'BALANCE',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  color: Color(0xFF7A6666),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '12 Days',
                                style: TextStyle(
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
                            border: Border.all(color: const Color(0xFFF2DED7)),
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
                            children: const [
                              Text(
                                'PENDING',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  color: Color(0xFF7A6666),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '01\nRequest',
                                style: TextStyle(
                                  fontSize: 22,
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

                  // ─── Section Header: Request History ──────────────
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 22,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Request History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _titleDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ─── Leave Cards List ─────────────────────────────
                  ..._leaveRecords.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: _buildLeaveCard(item),
                      )),
                  const SizedBox(height: 80),
                ],
              ),
            ),

            // In-page FAB matching the screenshot's floating button
            Positioned(
              right: 20,
              bottom: 16,
              child: GestureDetector(
                onTap: _onFabPressed,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2DED7)),
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
          // Top Row: Date & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['date'] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Colors.grey.shade600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: item['statusBg'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item['status'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: item['statusColor'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            item['title'] as String,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: _titleDark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),

          // Duration & Icon
          Row(
            children: [
              Icon(
                item['icon'] as IconData,
                size: 16,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                item['duration'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
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
