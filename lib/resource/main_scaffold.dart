import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
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

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onNavTap,
    this.onFabPressed,
    this.appBarTitle,
    this.appBarLeading,
    this.appBarActions,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  static const Color _titleColor = Color(0xFF5A0000);
  String role = 'client';

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? 'client';
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
        title: Text(
          widget.appBarTitle ?? 'Ripal Design',
          style: TextStyle(
            color: _titleColor,
            fontWeight: FontWeight.bold,
            fontSize: role == 'admin' ? 22 : 24,
          ),
        ),
        titleSpacing: -5.5,
        actions: widget.appBarActions ?? [
          if (role == 'admin')
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, color: _titleColor),
              onPressed: () {},
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: role == 'admin' ? 16 : 18,
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
        role: role,
      ),
    );
  }
}
