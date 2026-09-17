import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routes.dart';
import 'screens/worker_dashboard_screen.dart';
import 'screens/worker_settings_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/password_update_screen.dart';
import 'screens/view_member_screen.dart';
import 'screens/upload_files_screen.dart';
import 'screens/project_files_screen.dart';
import 'screens/leave_history_screen.dart';
import 'screens/leave_request_screen.dart';
import 'screens/leave_request_submitted_screen.dart';
import 'screens/upload_profile_photo_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/project_view_screen.dart';
import 'screens/worker_screen.dart';

void main() {
  runApp(const RipalDesignApp());
}

class RipalDesignApp extends StatelessWidget {
  const RipalDesignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ripal Design',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.dashboard,
      routes: {
        AppRoutes.dashboard: (context) => const WorkerDashboardScreen(),
        AppRoutes.settings: (context) => const WorkerSettingsScreen(),
        AppRoutes.editProfile: (context) => const EditProfileScreen(),
        AppRoutes.securitySettings: (context) => const PasswordUpdateScreen(),
        AppRoutes.executionCrew: (context) => const ExecutionCrewScreen(),
        AppRoutes.viewMember: (context) => const ExecutionCrewScreen(),
        AppRoutes.uploadFiles: (context) => const UploadFilesScreen(),
        AppRoutes.projectFiles: (context) => const ProjectFilesScreen(),
        AppRoutes.leaveHistory: (context) => const LeaveHistoryScreen(),
        AppRoutes.leaveRequest: (context) => const LeaveRequestScreen(),
        AppRoutes.leaveSubmitted: (context) => const LeaveRequestSubmittedScreen(),
        AppRoutes.uploadProfilePhoto: (context) => const UploadProfilePhotoScreen(),
        AppRoutes.activity: (context) => const ActivityScreen(),
        AppRoutes.projectView: (context) => const ProjectViewScreen(),
        AppRoutes.worker: (context) => const WorkerScreen(),
      },
    );
  }
}
