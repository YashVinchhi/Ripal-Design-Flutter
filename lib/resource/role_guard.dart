import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';

/// Centralizes role checks for screens to strictly enforce RBAC.
class RoleGuard {
  static Future<bool> checkAccess(
    BuildContext context, {
    required List<String> allowedRoles,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final currentRole = (prefs.getString('role') ?? '').trim().toLowerCase();
    final isAllowed = allowedRoles
        .map((r) => r.trim().toLowerCase())
        .contains(currentRole);

    if (!isAllowed) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Access Denied: You do not have permission to view this screen.'),
            backgroundColor: Color(0xFF5A0000),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      }
      return false;
    }
    return true;
  }

  static Future<bool> allow(
    BuildContext context, {
    required String role,
    required String requiredRole,
  }) async {
    return checkAccess(context, allowedRoles: [requiredRole]);
  }
}

/// A wrapper widget that prevents unauthorized roles from rendering sensitive screens.
class RoleGuardedScreen extends StatefulWidget {
  final List<String> allowedRoles;
  final Widget child;

  const RoleGuardedScreen({
    super.key,
    required this.allowedRoles,
    required this.child,
  });

  @override
  State<RoleGuardedScreen> createState() => _RoleGuardedScreenState();
}

class _RoleGuardedScreenState extends State<RoleGuardedScreen> {
  bool _isChecking = true;
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();
    _verifyAccess();
  }

  Future<void> _verifyAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final currentRole = (prefs.getString('role') ?? '').trim().toLowerCase();
    final normalizedAllowed = widget.allowedRoles
        .map((r) => r.trim().toLowerCase())
        .toList();

    final allowed = normalizedAllowed.contains(currentRole);

    if (!allowed) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Access Denied: You do not have permission to view this screen.'),
            backgroundColor: Color(0xFF5A0000),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        setState(() {
          _isAuthorized = true;
          _isChecking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking || !_isAuthorized) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFF7F2),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF5A0000),
          ),
        ),
      );
    }
    return widget.child;
  }
}
