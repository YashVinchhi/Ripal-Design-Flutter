import 'package:flutter/material.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin_project_detail_screen.dart';
import 'package:ripal_design/screen/admin_team_screen.dart';
import 'package:ripal_design/screen/admin_upload_file_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';

class AdminActivityScreen extends StatefulWidget {
  const AdminActivityScreen({super.key});

  @override
  State<AdminActivityScreen> createState() => _AdminActivityScreenState();
}

class _AdminActivityScreenState extends State<AdminActivityScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _titleDark = Color(0xFF2A0501);
  static const Color _cardPink = Color(0xFFFCEFEA);

  int _currentIndex = 0;
  final int _currentStep = 4; // Step 4: Activity

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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
    } else if (step == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminTeamScreen()));
    } else if (step == 3) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminUploadFileScreen()));
    } else if (step == 4) {
      // Already on Activity step
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: _currentIndex,
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      appBarTitle: 'SITE LOG',
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
              // Step Indicator Row (Pixel-perfect)
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
              const SizedBox(height: 28),

              // Activity Feed Header
              Text(
                'ACTIVITY FEED',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Live Construction Log',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 48,
                height: 3,
                color: primaryColor,
              ),
              const SizedBox(height: 28),

              // Item 1: Panorama.png
              _buildFeedItem(
                icon: Icons.upload_file_outlined,
                iconBg: _cardPink,
                iconColor: primaryColor,
                titleWidget: const Text(
                  'Panorama.png',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                timestamp: 'Jun 01, 2026 • 10:42 AM',
              ),
              const SizedBox(height: 12),

              // Item 2: Progress updated
              _buildFeedItem(
                icon: Icons.refresh,
                iconBg: _cardPink,
                iconColor: primaryColor,
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15, color: _titleDark),
                        children: const [
                          TextSpan(text: 'Admin ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'progress updated:'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Auto-calculated to 30%',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: const LinearProgressIndicator(
                        value: 0.30,
                        minHeight: 5,
                        backgroundColor: Color(0xFFE8D5CE),
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                  ],
                ),
                timestamp: 'May 02, 2026 • 03:15 PM',
              ),
              const SizedBox(height: 12),

              // Item 3: Added team member
              _buildFeedItem(
                icon: Icons.person_add_outlined,
                iconBg: _cardPink,
                iconColor: primaryColor,
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15, color: _titleDark),
                        children: const [
                          TextSpan(text: 'Admin ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'added team member'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Yash Vinchhi',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                timestamp: 'May 02, 2026 • 09:00 AM',
              ),
              const SizedBox(height: 12),

              // Item 4: Created milestone (Flag icon)
              _buildFeedItem(
                icon: Icons.flag,
                iconBg: primaryColor,
                iconColor: Colors.white,
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15, color: _titleDark),
                        children: const [
                          TextSpan(text: 'Admin ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'created milestone:'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Planning complete',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                timestamp: 'Apr 28, 2026 • 11:20 AM',
              ),
              const SizedBox(height: 12),

              // Item 5: Uploaded file
              _buildFeedItem(
                icon: Icons.upload_file_outlined,
                iconBg: _cardPink,
                iconColor: primaryColor,
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 15, color: _titleDark),
                        children: const [
                          TextSpan(text: 'Admin ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'uploaded file'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Exterior_Render_Final.jpg',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                timestamp: 'Apr 25, 2026 • 04:55 PM',
              ),
              const SizedBox(height: 32),

              // Bottom Save Draft & Finish Buttons
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Activity log saved as draft!'),
                        backgroundColor: primaryColor,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save Draft',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Project created successfully!'),
                        backgroundColor: primaryColor,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminProjectDetailScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Finish Project',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                    ],
                  ),
                ),
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

  Widget _buildFeedItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required Widget titleWidget,
    required String timestamp,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5CCC9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleWidget,
                const SizedBox(height: 6),
                Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
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
