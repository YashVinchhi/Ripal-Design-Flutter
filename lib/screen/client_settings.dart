import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/resource/client_scaffold.dart';
import 'package:ripal_design/resource/setting_group.dart';
import 'package:ripal_design/resource/setting_tile.dart';
import 'package:ripal_design/resource/setting_switch_tile.dart';
import 'package:ripal_design/screen/client_dashborad.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/client_contactus.dart';
import 'package:ripal_design/screen/login_screen.dart';

class ClientSettings extends StatefulWidget {
  const ClientSettings({super.key});

  @override
  State<ClientSettings> createState() => _ClientSettingsState();
}

class _ClientSettingsState extends State<ClientSettings> {
  static const Color _primaryColor = Color(0xFF5A0000); // Maroon

  bool _pushNotifications = true;
  bool _emailReports = false;

  String userName = 'Your Name';
  String userEmail = 'youremail@example.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Your Name';
      userEmail = prefs.getString('userEmail') ?? 'youremail@example.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClientScaffold(
      currentIndex: 3,
      appBarTitle: 'Settings',
      appBarLeading: IconButton(
        icon: const Icon(Icons.close, color: _primaryColor),
        onPressed: () => Navigator.pop(context),
      ),
      onNavTap: (index) {
        // if (index == 3) return; // Already on Settings

        if (index == 0) {
          // Instead of pop, explicitly go back to Dashboard to avoid closing the app
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Client_Dashborad()),
            // (route) => false,
          );
          return;
        }
        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClientProjectView()),
          );
          return;
        }
        if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClientContactus()),
          );
          return;
        }
      },
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 8.0,
            bottom:
                100.0, // Extra padding so content isn't hidden behind the bottom nav bar
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // ─── Profile Avatar ────────────────────────────────────
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: const Color(0xFFFFF0E5),
                      child: ClipOval(
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/a/ac/Transparent_square.png', // Fallback transparent grid
                          width: 84,
                          height: 84,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.person,
                                size: 84,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF9E4723), // Brown pencil badge
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userEmail,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 32),

              // ─── ACCOUNT ─────────────────────────────────────────
              SettingGroup(
                title: 'ACCOUNT',
                children: [
                  SettingTile(
                    icon: Icons.person_outline,
                    title: 'Profile Information',
                    onTap: () {},
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

              // ─── PREFERENCES ──────────────────────────────────────
              SettingGroup(
                title: 'PREFERENCES',
                children: [
                  SettingTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English (US)',
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingTile(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: 'Light Mode',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ─── SUPPORT ──────────────────────────────────────────
              SettingGroup(
                title: 'SUPPORT',
                children: [
                  SettingTile(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                  SettingTile(
                    icon: Icons.info_outline,
                    title: 'App Version',
                    trailing: Text(
                      'v0.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ─── LOG OUT ──────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    
                    if (!context.mounted) return;
                    // Explicitly route to login screen and clear the stack
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const login_Screen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFF5A0000),
                    size: 18,
                  ),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFF5A0000),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Logged in as $userEmail',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
