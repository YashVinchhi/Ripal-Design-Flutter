import 'package:flutter/material.dart';
import 'package:ripal_design/resource/checkered_placeholder.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/worker_step_header.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker_activity_screen.dart';
import 'package:ripal_design/screen/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker_settings_screen.dart';
import 'package:ripal_design/screen/worker_upload_files_screen.dart';
import 'package:ripal_design/screen/worker_view_member_screen.dart';

class WorkerProjectViewScreen extends StatefulWidget {
  final String projectName;
  final String clientName;
  final String budget;
  final String timeline;
  final String type;
  final String location;

  const WorkerProjectViewScreen({
    super.key,
    this.projectName = 'The Obsidian House',
    this.clientName = 'Vanguard Properties',
    this.budget = '₹12,50,000',
    this.timeline = 'Oct 2023 - Dec 2024',
    this.type = 'Residential Luxury',
    this.location = 'Malibu, CA — Pacific Coast Highway',
  });

  @override
  State<WorkerProjectViewScreen> createState() => _WorkerProjectViewScreenState();
}

class _WorkerProjectViewScreenState extends State<WorkerProjectViewScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF2A0501);

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
      // Current step
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WorkerActivityScreen()),
      );
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
        title: Text(
          widget.projectName.toUpperCase(),
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
            letterSpacing: 0.5,
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
                currentStep: 1,
                onStepTap: _onStepTap,
              ),
              const SizedBox(height: 12),

              // Hero Banner with Checkered Blueprint & Gradient
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const CheckeredPlaceholder(
                        color1: Color(0xFF7E8488),
                        color2: Color(0xFF6B7175),
                        squareSize: 14,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.25),
                              Colors.black.withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 14,
                        left: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B1812),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'UNDER CONSTRUCTION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '75% COMPLETE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 14,
                        right: 14,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.projectName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    widget.location,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Metadata Block
              _buildMetaItem('CLIENT', widget.clientName),
              const SizedBox(height: 14),
              _buildMetaItem('BUDGET', widget.budget),
              const SizedBox(height: 14),
              _buildMetaItem('TIMELINE', widget.timeline),
              const SizedBox(height: 14),
              _buildMetaItem('TYPE', widget.type),
              const SizedBox(height: 20),

              const Divider(color: Color(0xFFF0DCD5), thickness: 1),
              const SizedBox(height: 20),

              // Key Milestones Section
              const Text(
                'Key Milestones',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 18),

              // Timeline List
              _buildMilestoneTimeline(),
              const SizedBox(height: 28),

              // Project Team Section
              Text(
                'PROJECT TEAM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              _buildTeamMemberCard(
                name: 'Rajibul Sheikh',
                role: 'Lead Architect',
              ),
              const SizedBox(height: 10),
              _buildTeamMemberCard(
                name: 'Yash Vinchhi',
                role: 'Structural Lead',
              ),
              const SizedBox(height: 28),

              // Site Gallery Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SITE GALLERY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Text(
                    'VIEW ALL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildGallerySquare()),
                  const SizedBox(width: 12),
                  Expanded(child: _buildGallerySquare()),
                  const SizedBox(width: 12),
                  Expanded(child: _buildGallerySquare()),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _titleDark,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          title: 'Interior Fit',
          status: 'Active',
          description:
              'Installation of custom marble surfaces and smart home integration systems.',
          isActive: true,
          isFirst: true,
          isLast: false,
          cardColor: const Color(0xFFFDF1EC),
        ),
        _buildTimelineItem(
          title: 'Structural Framing',
          status: 'Completed',
          description:
              'Final inspection of the primary cantilevered steel support structure.',
          isActive: true,
          isFirst: false,
          isLast: false,
          cardColor: Colors.white,
        ),
        _buildTimelineItem(
          title: 'Planning & Permits',
          status: 'Completed',
          description:
              'All environmental impact assessments approved by the coastal commission.',
          isActive: false,
          isFirst: false,
          isLast: true,
          cardColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String status,
    required String description,
    required bool isActive,
    required bool isFirst,
    required bool isLast,
    required Color cardColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator line + dot
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : const Color(0xFFE2C4BD),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: const Color(0xFFE2C4BD),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Milestone Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF0DCD5)),
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
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isActive ? primaryColor : _titleDark,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard({
    required String name,
    required String role,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0DCD5)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2C4BD), width: 1),
            ),
            child: const ClipOval(
              child: CheckeredPlaceholder(squareSize: 4),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _titleDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified,
            color: primaryColor,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySquare() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF0DCD5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: const CheckeredPlaceholder(squareSize: 6),
      ),
    );
  }
}
