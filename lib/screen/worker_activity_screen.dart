import 'package:flutter/material.dart';
import 'package:ripal_design/resource/checkered_placeholder.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/worker_step_header.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker_project_view_screen.dart';
import 'package:ripal_design/screen/worker_settings_screen.dart';
import 'package:ripal_design/screen/worker_upload_files_screen.dart';
import 'package:ripal_design/screen/worker_view_member_screen.dart';

class WorkerActivityScreen extends StatefulWidget {
  const WorkerActivityScreen({super.key});

  @override
  State<WorkerActivityScreen> createState() => _WorkerActivityScreenState();
}

class _WorkerActivityScreenState extends State<WorkerActivityScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _subTitleBrown = Color(0xFF9C5B43);
  static const Color _cardPink = Color(0xFFFBECEB);

  int _currentIndex = 0;

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
        MaterialPageRoute(builder: (context) => const WorkerSettingsScreen()),
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerViewMemberScreen()),
      );
    } else if (step == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
      );
    } else if (step == 4) {
      // Current step
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'SITE LOG',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: 1.0,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 4-Step workflow header
              WorkerStepHeader(
                currentStep: 4,
                onStepTap: _onStepTap,
              ),
              const SizedBox(height: 16),

              // Activity Feed Header
              Text(
                'ACTIVITY FEED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Colors.brown.shade400,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Live Construction Log',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 44,
                height: 2,
                color: primaryColor,
              ),
              const SizedBox(height: 24),

              // ─── CARD 1: File Upload (Panorama.png) ───────────
              _buildFeedCard(
                iconWidget: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _cardPink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.upload_file_outlined,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Panorama.png',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _subTitleBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jun 01, 2026 • 10:42 AM',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ─── CARD 2: Progress Updated ─────────────────────
              _buildFeedCard(
                iconWidget: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _cardPink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: _titleDark),
                        children: [
                          TextSpan(
                            text: 'Admin ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'progress updated:'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Auto-calculated to 30%',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: _subTitleBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'May 02, 2026 • 03:15 PM',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.30,
                        backgroundColor: _cardPink,
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ─── CARD 3: Added Team Member ────────────────────
              _buildFeedCard(
                iconWidget: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _cardPink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1_outlined,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: _titleDark),
                        children: [
                          TextSpan(
                            text: 'Admin ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'added team member'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Yash Vinchhi',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _subTitleBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'May 02, 2026 • 09:00 AM',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ─── CARD 4: Milestone Completed ──────────────────
              _buildFeedCard(
                iconWidget: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.flag,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: _titleDark),
                        children: [
                          TextSpan(
                            text: 'Admin ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'created milestone:'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Planning complete',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Apr 28, 2026 • 11:20 AM',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ─── CARD 5: Uploaded File ────────────────────────
              _buildFeedCard(
                iconWidget: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _cardPink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.upload_file_outlined,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: _titleDark),
                        children: [
                          TextSpan(
                            text: 'Admin ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'uploaded file'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Exterior_Render_Final.jpg',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _subTitleBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Apr 25, 2026 • 04:55 PM',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedCard({
    required Widget iconWidget,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF2DED7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWidget,
          const SizedBox(width: 14),
          Expanded(child: content),
        ],
      ),
    );
  }
}
