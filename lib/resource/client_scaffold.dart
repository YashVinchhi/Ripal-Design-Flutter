import 'package:flutter/material.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';

/// A shared Scaffold wrapper used across all client screens.
/// Provides the common AppBar, FAB, and BottomNavBar.
/// Each screen passes its own [body] and [onNavTap] callback
/// so navigation can use the correct [context].
class ClientScaffold extends StatelessWidget {
  /// The content to display in the body of the screen.
  final Widget body;

  /// The currently selected bottom nav tab index (0=Home, 1=Project, 2=Contact).
  final int currentIndex;

  /// Called when a bottom nav tab is tapped. Receives the tapped [index].
  /// Handle navigation inside this callback using the screen's own [context].
  final Function(int index) onNavTap;

  /// Called when the FAB (+) is pressed.
  /// If null, the FAB is hidden.
  final VoidCallback? onFabPressed;

  /// Custom title for the AppBar. Defaults to 'Ripal Design'.
  final String? appBarTitle;

  /// Custom leading widget for the AppBar. Defaults to a grid view icon.
  final Widget? appBarLeading;

  const ClientScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onNavTap,
    this.onFabPressed,
    this.appBarTitle,
    this.appBarLeading,
  });

  static const Color _titleColor = Color(0xFF5A0000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: appBarLeading ??
            IconButton(
              icon: const Icon(Icons.grid_view_outlined, color: _titleColor),
              onPressed: () {},
            ),
        title: Text(
          appBarTitle ?? 'Ripal Design',
          style: const TextStyle(
            color: _titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        titleSpacing: -5.5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 18,
            ),
          ),
        ],
      ),
      body: body,
      floatingActionButton: onFabPressed != null
          ? FloatingActionButton(
              onPressed: onFabPressed,
              backgroundColor: _titleColor,
              shape: const CircleBorder(),
              elevation: 4,
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }
}
