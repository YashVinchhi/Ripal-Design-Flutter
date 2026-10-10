import 'package:flutter/material.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/admin/admin_leave_screen.dart';
import 'package:ripal_design/screen/admin/admin_leave_history_screen.dart';
import 'package:ripal_design/screen/admin/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin/admin_upload_file_screen.dart';
import 'package:ripal_design/screen/admin/admin_create_project.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/client/client_project_view.dart';
import 'package:ripal_design/screen/client/client_contactus.dart';
import 'package:ripal_design/screen/client/client_applay.dart';
import 'package:ripal_design/screen/worker/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker/worker_upload_files_screen.dart';

class AppNavigation {
  static void handleNavTap(
    BuildContext context,
    int index, {
    String? role,
    String? currentRole,
    int? currentIndex,
  }) {
    if (currentIndex != null && currentIndex == index) return;
    final r = (role ?? currentRole ?? 'admin').toLowerCase().trim();

    if (r == 'worker') {
      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WorkerLeaveHistoryScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WorkerUploadFilesScreen()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
          break;
      }
    } else if (r == 'employee') {
      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminLeaveHistoryScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminUploadFileScreen()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
          break;
      }
    } else if (r == 'admin') {
      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminLeaveScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminFinanceScreen()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
          break;
      }
    } else {
      // client
      switch (index) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ClientProjectView()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ClientContactus()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
          break;
      }
    }
  }

  static void handleFabPress(
    BuildContext context, [
    String role = 'admin',
    String? currentRole,
  ]) {
    final r = (currentRole ?? role).toLowerCase().trim();
    if (r == 'worker') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WorkerUploadFilesScreen()),
      );
    } else if (r == 'employee' || r == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AdminCreateProject()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ClientApplay()),
      );
    }
  }

  static void handleFabPressed(
    BuildContext context, {
    String? role,
    String? currentRole,
  }) {
    handleFabPress(context, role ?? currentRole ?? 'admin');
  }
}
