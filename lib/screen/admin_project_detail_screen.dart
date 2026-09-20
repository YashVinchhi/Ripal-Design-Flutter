import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_activity_screen.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin_team_screen.dart';
import 'package:ripal_design/screen/admin_upload_file_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminProjectDetailScreen extends StatefulWidget {
  final String projectName;
  final String clientName;
  final String budget;
  final String timeline;
  final String type;
  final String location;

  const AdminProjectDetailScreen({
    super.key,
    this.projectName = 'The Obsidian House',
    this.clientName = 'Vanguard Properties',
    this.budget = '₹12,50,000',
    this.timeline = 'Oct 2023 - Dec 2024',
    this.type = 'Residential Luxury',
    this.location = 'Malibu, CA — Pacific Coast Highway',
  });

  @override
  State<AdminProjectDetailScreen> createState() => _AdminProjectDetailScreenState();
}

class _AdminProjectDetailScreenState extends State<AdminProjectDetailScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _cardPink = Color(0xFFFCEFEA);

  int _currentIndex = 0;
  final int _currentStep = 1; // Step indicator default

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

  void _onStepTap(int step) {
    if (step == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
    } else if (step == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminTeamScreen()));
    } else if (step == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
    } else if (step == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminActivityScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: widget.projectName.toUpperCase(),
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
              // Step Indicators Row (Pixel-perfect)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(1, 'DETAILS'),
                  _buildStepDivider(1),
                  _buildStep(2, 'Team'),
                  _buildStepDivider(2),
                  _buildStep(3, 'Files'),
                  _buildStepDivider(3),
                  _buildStep(4, 'Activity'),
                ],
              ),
              const SizedBox(height: 24),

              // Hero Image Card Banner
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF333333),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Checkered pattern / photo background
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomPaint(
                          painter: _CheckeredPatternPainter(),
                        ),
                      ),
                    ),
                    // Dark Gradient overlay for text legibility
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.85),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Badges & Content
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'UNDER CONSTRUCTION',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                                ),
                                child: const Text(
                                  '75% COMPLETE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            widget.projectName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: Colors.white70, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                widget.location,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
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
              const SizedBox(height: 28),

              // Project Info Items
              _buildInfoItem('CLIENT', widget.clientName),
              const SizedBox(height: 16),
              _buildInfoItem('BUDGET', widget.budget),
              const SizedBox(height: 16),
              _buildInfoItem('TIMELINE', widget.timeline),
              const SizedBox(height: 16),
              _buildInfoItem('TYPE', widget.type),
              const SizedBox(height: 32),

              const Divider(color: Color(0xFFE5CCC9), height: 1),
              const SizedBox(height: 28),

              // Key Milestones Section
              const Text(
                'Key Milestones',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),

              // Milestones Vertical Timeline
              _buildMilestoneItem(
                title: 'Interior Fit',
                status: 'Active',
                isActive: true,
                description: 'Installation of custom marble surfaces and smart home integration systems.',
                isFirst: true,
                isLast: false,
              ),
              _buildMilestoneItem(
                title: 'Structural Framing',
                status: 'Completed',
                isActive: false,
                description: 'Final inspection of the primary cantilevered steel support structure.',
                isFirst: false,
                isLast: false,
              ),
              _buildMilestoneItem(
                title: 'Planning & Permits',
                status: 'Completed',
                isActive: false,
                description: 'All environmental impact assessments approved by the coastal commission.',
                isFirst: false,
                isLast: true,
              ),
              const SizedBox(height: 32),

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

              _buildTeamMemberCard('Rajibul Sheikh', 'Lead Architect'),
              const SizedBox(height: 12),
              _buildTeamMemberCard('Yash Vinchhi', 'Structural Lead'),
              const SizedBox(height: 32),

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

  Widget _buildStep(int number, String title) {
    final bool isActive = _currentStep == number;
    final bool isCompleted = _currentStep > number;

    return GestureDetector(
      onTap: () => _onStepTap(number),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive
                  ? primaryColor
                  : (isCompleted ? primaryColor.withOpacity(0.8) : const Color(0xFFF2E6E3)),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text(
                      number.toString(),
                      style: TextStyle(
                        color: isActive || isCompleted ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? primaryColor : Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider(int afterStep) {
    final bool isCompleted = _currentStep > afterStep;
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? primaryColor : const Color(0xFFF2E6E3),
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _titleDark,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneItem({
    required String title,
    required String status,
    required bool isActive,
    required String description,
    required bool isFirst,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Circle and Vertical Line
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : (status == 'Completed' ? primaryColor : const Color(0xFFE0C0B0)),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFE0C0B0),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Milestone Content Box
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isActive ? _cardPink : const Color(0xFFFFF7F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive ? const Color(0xFFE0C0B0) : const Color(0xFFE5CCC9),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _titleDark,
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isActive ? primaryColor : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(String name, String role) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5CCC9)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _cardPink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomPaint(
                painter: _CheckeredPatternPainter(),
              ),
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _titleDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const Icon(Icons.verified_outlined, color: primaryColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildGallerySquare() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: _cardPink,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5CCC9)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CustomPaint(
            painter: _CheckeredPatternPainter(),
          ),
        ),
      ),
    );
  }
}

class _CheckeredPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = const Color(0xFFECE4E0);
    final paint2 = Paint()..color = const Color(0xFFF7F1EE);

    const squareSize = 10.0;
    for (double x = 0; x < size.width; x += squareSize) {
      for (double y = 0; y < size.height; y += squareSize) {
        final isEven = ((x / squareSize).floor() + (y / squareSize).floor()) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, squareSize, squareSize),
          isEven ? paint1 : paint2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
