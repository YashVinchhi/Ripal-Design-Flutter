import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/main_scaffold.dart';
import 'package:ripal_design/resource/setting_tile.dart';
import 'package:ripal_design/resource/setting_group.dart';
import 'package:ripal_design/resource/setting_switch_tile.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/client_applay.dart';
import 'package:ripal_design/screen/edit_profile_screen.dart';
import 'package:ripal_design/screen/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

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

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? 'admin';
      userName = prefs.getString('userName') ?? (role == 'admin' ? 'Ar. Ripal Patel' : 'Client User');
      userEmail = prefs.getString('userEmail') ?? (role == 'admin' ? 'admin@gmail.com' : 'client@gmail.com');
    });
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

  void _onNavTap(int index) {
    if (role == 'admin') {
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
        return;
      }
    } else {
      if (index == 0) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
        return;
      }
      if (index == 1) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ClientProjectView()));
        return;
      }
      if (index == 2) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminFinanceScreen()));
        return;
      }
      if (index == 3) {
        return;
      }
    }
  }

  void _onFabPressed() {
    if (role == 'admin') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminCreateProject()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientApplay()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      appBarTitle: 'Settings',
      onNavTap: _onNavTap,
      onFabPressed: _onFabPressed,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              // ─── PROFILE HEADER ─────────────────────────────────
              GestureDetector(
                onTap: _openEditProfile,
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: salmonColor.withOpacity(0.2),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFFF5EBE6),
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: Color(0xFF5A0000),
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
                    const SizedBox(height: 12),
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                        builder: (context) => const login_Screen(),
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
          ),
        ),
      ),
    );
  }
}
