import 'package:flutter/material.dart';
import 'package:ripal_design/resource/widgets/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/controllers/role_guard.dart';
import 'package:ripal_design/resource/widgets/app_notification_icon.dart';
import 'package:ripal_design/resource/widgets/worker_step_header.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker/worker_activity_screen.dart';
import 'package:ripal_design/screen/worker/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker/worker_project_view_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/worker/worker_upload_files_screen.dart';

class WorkerViewMemberScreen extends StatefulWidget {
  final String projectName;

  const WorkerViewMemberScreen({
    super.key,
    this.projectName = 'Test 1',
  });

  @override
  State<WorkerViewMemberScreen> createState() => _WorkerViewMemberScreenState();
}

class _WorkerViewMemberScreenState extends State<WorkerViewMemberScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);

  int _currentIndex = 0;

  final List<Map<String, String>> _crewMembers = const [
    {
      'initials': 'DD',
      'name': 'Deep Dudhaiya',
      'role': 'worker',
      'email': 'apixgamer40@gmail.com',
    },
    {
      'initials': 'RS',
      'name': 'Rajibul Sheikh',
      'role': 'worker',
      'email': 'rajibulsheikh098@gmail.com',
    },
    {
      'initials': 'YV',
      'name': 'Yash Vinchhi',
      'role': 'worker',
      'email': 'behappywithyash@gmail.com',
    },
    {
      'initials': 'DD',
      'name': 'Deep Dudhaiya',
      'role': 'worker',
      'email': 'apixgamer40@gmail.com',
    },
    {
      'initials': 'RS',
      'name': 'Rajibul Sheikh',
      'role': 'worker',
      'email': 'rajibulsheikh098@gmail.com',
    },
    {
      'initials': 'YV',
      'name': 'Yash Vinchhi',
      'role': 'worker',
      'email': 'behappywithyash@gmail.com',
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkerLeaveHistoryScreen()),
      );
      return;
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
      MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
    );
  }

  void _onStepTap(int step) {
    if (step == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerProjectViewScreen()),
      );
    } else if (step == 2) {
      // Current step
    } else if (step == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
      );
    } else if (step == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerActivityScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuardedScreen(
      allowedRoles: const ['worker', 'employee', 'admin'],
      child: Scaffold(
        backgroundColor: _bgCream,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PROJECT DETAILS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                widget.projectName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
            ],
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 4-Step workflow header
              WorkerStepHeader(
                currentStep: 2,
                onStepTap: _onStepTap,
              ),
              const SizedBox(height: 16),

              // Execution Crew Heading
              const Text(
                'Execution Crew',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 16),

              // Outer Card wrapper
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF2DED7)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: _crewMembers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final member = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < _crewMembers.length - 1 ? 12.0 : 0.0,
                      ),
                      child: _buildMemberTile(member),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildMemberTile(Map<String, String> member) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF2DED7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF9EDE8),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              member['initials']!,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member['name']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _titleDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member['role']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member['email']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
