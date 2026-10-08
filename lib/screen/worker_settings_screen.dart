import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/app_image_helper.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/setting_group.dart';
import 'package:ripal_design/resource/setting_switch_tile.dart';
import 'package:ripal_design/resource/setting_tile.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/edit_profile_screen.dart';
import 'package:ripal_design/screen/login_screen.dart';
import 'package:ripal_design/screen/upload_profile_photo_screen.dart';
import 'package:ripal_design/screen/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker_password_update_screen.dart';
import 'package:ripal_design/screen/worker_upload_files_screen.dart';

class WorkerSettingsScreen extends StatefulWidget {
  const WorkerSettingsScreen({super.key});

  @override
  State<WorkerSettingsScreen> createState() => _WorkerSettingsScreenState();
}

class _WorkerSettingsScreenState extends State<WorkerSettingsScreen> {
  static const Color primaryColor = Color(0xFF5A0000);
  static const Color _bgCream = Color(0xFFFFF7F2);
  static const Color _titleDark = Color(0xFF1E1E1E);

  int _currentIndex = 3;
  bool _pushNotifications = true;
  bool _emailReports = false;

  String _userName = 'Your Name';
  String _userEmail = 'youremail@example.com';
  String? _userAvatarPath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Your Name';
      _userEmail = prefs.getString('userEmail') ?? 'youremail@example.com';
      _userAvatarPath = prefs.getString('userAvatarPath');
    });
  }

  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
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
      return; // Already on settings
    }
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkerUploadFilesScreen()),
    );
  }

  void _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
    if (result == true) {
      _loadUserData();
    }
  }

  void _openUploadPhoto() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadProfilePhotoScreen()),
    );
  }

  void _openSecurity() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkerPasswordUpdateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _userName.isNotEmpty ? _userName : 'Your Name';
    final displayEmail = _userEmail.isNotEmpty ? _userEmail : 'youremail@example.com';
    final loggedInText = 'Logged in as ${_userName.toLowerCase().replaceAll(' ', '')}';

    return Scaffold(
      backgroundColor: _bgCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: primaryColor),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
            }
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: primaryColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: _openUploadPhoto,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2C4BD), width: 1),
                ),
                child: ClipOval(
                  child: buildProfileImage(
                    _userAvatarPath,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                    fallback: const CircleAvatar(
                      backgroundColor: Color(0xFFF5EBE6),
                      child: Icon(Icons.person, size: 18, color: primaryColor),
                    ),
                  ),
                ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),

              // ─── Profile Avatar Header ──────────────────────────
              Center(
                child: GestureDetector(
                  onTap: _openUploadPhoto,
                  child: Stack(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFF0DCD5),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: buildProfileImage(
                            _userAvatarPath,
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                            fallback: const CircleAvatar(
                              backgroundColor: Color(0xFFF5EBE6),
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF8B3A1C),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _titleDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                displayEmail,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 28),

              // ─── ACCOUNT SECTION ─────────────────────────────────
              SettingGroup(
                title: 'ACCOUNT',
                children: [
                  SettingTile(
                    icon: Icons.person_outline,
                    title: 'Profile Information',
                    onTap: _openEditProfile,
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF7EBE8)),
                  SettingTile(
                    icon: Icons.shield_outlined,
                    title: 'Security & Password',
                    onTap: _openSecurity,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ─── NOTIFICATIONS SECTION ───────────────────────────
              SettingGroup(
                title: 'NOTIFICATIONS',
                children: [
                  SettingSwitchTile(
                    icon: Icons.notifications_none,
                    title: 'Push Notifications',
                    subtitle: 'Alerts, updates and activities',
                    value: _pushNotifications,
                    onChanged: (v) => setState(() => _pushNotifications = v),
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF7EBE8)),
                  SettingSwitchTile(
                    icon: Icons.mail_outline,
                    title: 'Email Reports',
                    subtitle: 'Weekly summaries and news',
                    value: _emailReports,
                    onChanged: (v) => setState(() => _emailReports = v),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ─── PREFERENCES SECTION ─────────────────────────────
              SettingGroup(
                title: 'PREFERENCES',
                children: [
                  SettingTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English (US)',
                    onTap: () {},
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF7EBE8)),
                  SettingTile(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: 'Light Mode',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ─── ABOUT & HELP ────────────────────────────────────
              SettingGroup(
                title: 'ABOUT & HELP',
                children: [
                  SettingTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'FAQs and support center',
                    onTap: () {
                      _showInfoDialog('Help Center', 'Reach out to support@ripaldesign.com or call +91 94267 89012 for assistance.');
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF7EBE8)),
                  SettingTile(
                    icon: Icons.security,
                    title: 'Privacy Policy',
                    subtitle: 'Terms of service & privacy',
                    onTap: () {
                      _showInfoDialog('Privacy Policy', 'Your data is handled securely under Ripal Design Candidate & User Privacy terms.');
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF7EBE8)),
                  SettingTile(
                    icon: Icons.info_outline,
                    title: 'About Ripal Design',
                    subtitle: 'Version 1.0.0',
                    onTap: () {
                      _showInfoDialog('About Ripal Design', 'Ripal Design Architecture Studio\nVersion 1.0.0');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ─── LOG OUT BUTTON ──────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    navigator.pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFF333333),
                    size: 18,
                  ),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD0D0D0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Logged in as text
              Text(
                loggedInText,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
