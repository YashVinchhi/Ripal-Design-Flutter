
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/app_image_helper.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/setting_tile.dart';
import 'package:ripal_design/resource/setting_group.dart';
import 'package:ripal_design/resource/setting_switch_tile.dart';
import 'package:ripal_design/screen/edit_profile_screen.dart';
import 'package:ripal_design/screen/login_screen.dart';
import 'package:ripal_design/screen/worker_password_update_screen.dart';
import 'package:ripal_design/screen/upload_profile_photo_screen.dart';
import 'package:ripal_design/resource/app_navigation.dart';
import 'package:ripal_design/service/user_service.dart';

class SettingsScreen extends StatefulWidget {
  /// When [embeddedMode] is true, the widget renders only its body content
  /// (no MainScaffold/AppBar/BottomNav) so it can be embedded inside an
  /// IndexedStack in the client shell.
  final bool embeddedMode;

  const SettingsScreen({super.key, this.embeddedMode = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color primaryColor = const Color(0xFF5A0000);
  final Color salmonColor = const Color(0xFFE07A5F);

  bool _pushNotifications = true;
  bool _emailReports = false;
  String role = 'admin';
  String userName = '';
  String userEmail = '';
  String? avatarPath;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final user = await UserService.getCurrentUser();
    if (!mounted) return;
    setState(() {
      role = user.role;
      userName = user.name;
      userEmail = user.email;
      avatarPath = user.avatarPath;
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

  void _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
    if (result == true) {
      _loadRole();
    }
  }

  void _openUploadPhoto() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadProfilePhotoScreen()),
    );
    _loadRole();
  }

  void _onNavTap(int index) {
    AppNavigation.handleNavTap(context, index, currentRole: role);
  }

  void _onFabPressed() {
    AppNavigation.handleFabPressed(context, currentRole: role);
  }

  @override
  Widget build(BuildContext context) {
    // Embedded inside DashboardScreen's IndexedStack — no scaffold
    if (widget.embeddedMode) {
      return SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: _buildSettingsContent(),
      ));
    }

    // Standalone: full scaffold with nav bar
    return MainScaffold(
      currentIndex: 3,
      appBarTitle: 'Settings',
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: _buildSettingsContent(),
        ),
      ),
    );
  }

  Widget _buildSettingsContent() {
    return Column(
      children: [
        // ─── PROFILE HEADER ─────────────────────────────────
        Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: _openUploadPhoto,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: salmonColor.withValues(alpha: 0.2),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFFF5EBE6),
                        child: ClipOval(
                          child: buildProfileImage(
                            avatarPath,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            fallback: const Icon(
                              Icons.person,
                              size: 48,
                              color: Color(0xFF5A0000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF5A0000),
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
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _openEditProfile,
              child: Column(
                children: [
                    Text(
                      userName.isNotEmpty ? userName : (role == 'admin' ? 'Ar. Ripal Patel' : 'Client User'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail.isNotEmpty ? userEmail : (role == 'admin' ? 'admin@gmail.com' : 'client@gmail.com'),
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

              // ─── ACCOUNT ─────────────────────────────────────────
              SettingGroup(
                title: 'ACCOUNT',
                children: [
                  SettingTile(
                    icon: Icons.person_outline,
                    title: 'Profile Information',
                    onTap: _openEditProfile,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingTile(
                    icon: Icons.shield_outlined,
                    title: 'Security & Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WorkerPasswordUpdateScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ─── NOTIFICATIONS ────────────────────────────────────
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
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingSwitchTile(
                    icon: Icons.mail_outline,
                    title: 'Email Reports',
                    subtitle: 'Weekly summaries and news',
                    value: _emailReports,
                    onChanged: (v) => setState(() => _emailReports = v),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ─── PREFERENCES ─────────────────────────────────────
              SettingGroup(
                title: 'PREFERENCES',
                children: [
                  SettingTile(
                    icon: Icons.palette_outlined,
                    title: 'Appearance',
                    subtitle: 'Light theme',
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingTile(
                    icon: Icons.language_outlined,
                    title: 'Language',
                    subtitle: 'English (US)',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ─── ABOUT & HELP ────────────────────────────────────
              SettingGroup(
                title: 'ABOUT & HELP',
                children: [
                  SettingTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'FAQs and support center',
                    onTap: () {
                      _showInfoDialog('Help & Support', 'Reach out to support@ripaldesign.com or call +91 94267 89012 for assistance.');
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingTile(
                    icon: Icons.security,
                    title: 'Privacy Policy',
                    subtitle: 'Terms of service & privacy',
                    onTap: () {
                      _showInfoDialog('Privacy Policy', 'We process your data securely according to our privacy policy terms.');
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
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
              const SizedBox(height: 32),

              // ─── LOGOUT BUTTON ────────────────────────────────────
              SizedBox(
                width: double.infinity,
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
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
        ],
    );
  }
}
