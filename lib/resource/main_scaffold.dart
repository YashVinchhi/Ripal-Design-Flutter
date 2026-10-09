import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/resource/app_image_helper.dart';
import 'package:ripal_design/resource/app_notification_icon.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/worker/worker_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A shared Scaffold wrapper used across screens.
/// Provides the common AppBar, FAB, and BottomNavBar.
class MainScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;
  final Function(int index) onNavTap;
  final VoidCallback? onFabPressed;
  final String? appBarTitle;
  final Widget? appBarLeading;
  final List<Widget>? appBarActions;
  final String? role;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onNavTap,
    this.onFabPressed,
    this.appBarTitle,
    this.appBarLeading,
    this.appBarActions,
    this.role,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  static const Color _titleColor = Color(0xFF5A0000);
  String role = '';
  String? _userAvatarPath;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  @override
  void didUpdateWidget(covariant MainScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        role = widget.role ?? prefs.getString('role') ?? '';
        _userAvatarPath = prefs.getString('userAvatarPath');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveRole = (widget.role != null && widget.role!.isNotEmpty)
        ? widget.role!
        : role;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading:
            widget.appBarLeading ??
            IconButton(
              icon: const Icon(Icons.grid_view_outlined, color: _titleColor),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
                (route) => false,
              ),
            ),
        title: Text(
          widget.appBarTitle ?? 'Ripal Design',
          style: TextStyle(
            color: _titleColor,
            fontWeight: FontWeight.bold,
            fontSize: (effectiveRole == 'admin' || effectiveRole == 'worker') ? 22 : 24,
          ),
        ),
        titleSpacing: -5.5,
        actions: widget.appBarActions ?? [
          const AppNotificationIcon(),
          GestureDetector(
            onTap: () {
              if (effectiveRole.toLowerCase() == 'worker') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerSettingsScreen()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 4.0),
              child: Container(
                width: (effectiveRole == 'admin' || effectiveRole == 'worker') ? 32 : 36,
                height: (effectiveRole == 'admin' || effectiveRole == 'worker') ? 32 : 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2C4BD), width: 1.5),
                ),
                child: ClipOval(
                  child: buildProfileImage(
                    _userAvatarPath,
                    width: (effectiveRole == 'admin' || effectiveRole == 'worker') ? 32 : 36,
                    height: (effectiveRole == 'admin' || effectiveRole == 'worker') ? 32 : 36,
                    fit: BoxFit.cover,
                    fallback: const CircleAvatar(
                      backgroundColor: Color(0xFFF5EBE6),
                      child: Icon(Icons.person, size: 18, color: _titleColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: widget.body,
      floatingActionButton: widget.onFabPressed != null
          ? FloatingActionButton(
              onPressed: widget.onFabPressed,
              backgroundColor: _titleColor,
              shape: const CircleBorder(),
              elevation: 4,
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onNavTap,
        role: effectiveRole,
      ),
    );
  }
}
