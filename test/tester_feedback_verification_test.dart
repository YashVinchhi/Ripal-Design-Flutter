import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ripal_design/screen/admin/admin_leave_screen.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/worker/worker_activity_screen.dart';
import 'package:ripal_design/screen/worker/worker_project_files_screen.dart';
import 'package:ripal_design/screen/worker/worker_settings_screen.dart';
import 'package:ripal_design/screen/worker/worker_upload_files_screen.dart';
import 'package:ripal_design/screen/worker/worker_view_member_screen.dart';
import 'package:ripal_design/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  void configureViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    UserService.currentRole = 'admin';
    UserService.currentUserName = '';
    UserService.currentUserEmail = '';
  });

  group('Tester Issue 1: Employee Backward Navigation', () {
    testWidgets('Employee navigates to Settings and pressing back returns to Employee Dashboard without Admin screen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'employee', 'userName': 'Rachit'});
      UserService.currentRole = 'employee';
      UserService.currentUserName = 'Rachit';

      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardScreen(initialRole: 'employee'),
        ),
      );
      await tester.pumpAndSettle();

      // Must be on Employee Dashboard
      expect(find.text('Welcome, Rachit'), findsOneWidget);
      expect(find.text('TOTAL REVENUE'), findsNothing); // Admin only
      expect(find.text('Actions'), findsOneWidget);

      // Tap Settings quick action
      final settingsBtn = find.text('SETTINGS');
      expect(settingsBtn, findsOneWidget);
      await tester.ensureVisible(settingsBtn);
      await tester.tap(settingsBtn);
      await tester.pumpAndSettle();

      // Verify on SettingsScreen
      expect(find.text('Profile Information'), findsOneWidget);

      // Now navigate backward by tapping the app bar leading icon or calling pop
      final backButton = find.byType(IconButton).first;
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Must be safely back on Employee Dashboard, NEVER Admin
      expect(find.text('Welcome, Rachit'), findsOneWidget);
      expect(find.text('TOTAL REVENUE'), findsNothing);
      expect(find.text('Actions'), findsOneWidget);
    });

    testWidgets('Employee bottom navigation bar tabs stay in employee flow', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'employee', 'userName': 'Rachit'});
      UserService.currentRole = 'employee';
      UserService.currentUserName = 'Rachit';

      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardScreen(initialRole: 'employee'),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Leave tab (index 1)
      await tester.tap(find.text('Leave'));
      await tester.pumpAndSettle();

      // Employee leave tab should route to Leave History, not Admin Leave Approval
      expect(find.text('Leave History'), findsOneWidget);
      expect(find.text('TOTAL REVENUE'), findsNothing);

      // Tap Home tab (index 0) from Leave History
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Must return to Employee Dashboard, never Admin
      expect(find.text('Welcome, Rachit'), findsOneWidget);
      expect(find.text('TOTAL REVENUE'), findsNothing);
      expect(find.text('Actions'), findsOneWidget);
    });

    testWidgets('Employee visiting AdminLeaveScreen can go back to employee dashboard cleanly', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'employee', 'userName': 'Rachit'});
      UserService.currentRole = 'employee';
      UserService.currentUserName = 'Rachit';

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLeaveScreen())),
                child: const Text('Go to Leave'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go to Leave'));
      await tester.pumpAndSettle();

      expect(find.text('Leave Management'), findsOneWidget);

      // Tap back button
      final backBtn = find.byIcon(Icons.arrow_back);
      expect(backBtn, findsOneWidget);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();

      expect(find.text('Go to Leave'), findsOneWidget);
    });
  });

  group('Tester Issue 2: WorkerUI Figma Design Match', () {
    testWidgets('Worker dashboard displays all figma design components and exact quick actions', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker', 'userName': 'Niku'});
      UserService.currentRole = 'worker';
      UserService.currentUserName = 'Niku';

      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardScreen(initialRole: 'worker'),
        ),
      );
      await tester.pumpAndSettle();

      // Header overview
      expect(find.text('DASHBOARD OVERVIEW'), findsOneWidget);
      expect(find.text('Welcome, Niku'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is RichText && w.text.toPlainText().contains('12 Active Projects'),
        ),
        findsOneWidget,
      );

      // Stat cards matching Figma
      expect(find.text('ACTIVE PROJECTS'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
      expect(find.text('TEAM VELOCITY'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
      expect(find.text('8 New'), findsOneWidget);

      // Section: Assigned Projects
      expect(find.text('Assigned Projects'), findsOneWidget);
      expect(find.text('EXPLORE PROJECTS'), findsOneWidget);
      expect(find.text('Skyline Plaza'), findsOneWidget);
      expect(find.text('Azure Residence'), findsOneWidget);

      // Section: Quick Actions (exact 6 actions from Figma)
      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('VIEW PROJECT'), findsOneWidget);
      expect(find.text('UPLOAD FILES'), findsOneWidget);
      expect(find.text('TEAM VIEW'), findsOneWidget);
      expect(find.text('FILE VIEWS'), findsOneWidget);
      expect(find.text('LEAVE MANGE'), findsOneWidget);
      expect(find.text('ACTIVITY'), findsOneWidget);
    });
  });

  group('Tester Issue 3: Worker Floating Action Button Opens Leave Create', () {
    testWidgets('Worker dashboard FAB opens WorkerLeaveRequestScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker', 'userName': 'Niku'});
      UserService.currentRole = 'worker';

      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardScreen(initialRole: 'worker'),
        ),
      );
      await tester.pumpAndSettle();

      // Find FAB and tap it
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Must open WorkerLeaveRequestScreen
      expect(find.text('Request\nLeave'), findsOneWidget);
      expect(find.text('LEAVE TYPE'), findsOneWidget);
    });

    testWidgets('Worker Project Files screen FAB opens WorkerLeaveRequestScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker'});
      UserService.currentRole = 'worker';

      await tester.pumpWidget(
        const MaterialApp(
          home: WorkerProjectFilesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(find.text('Request\nLeave'), findsOneWidget);
    });

    testWidgets('Worker Upload Files screen FAB opens WorkerLeaveRequestScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker'});
      UserService.currentRole = 'worker';

      await tester.pumpWidget(
        const MaterialApp(
          home: WorkerUploadFilesScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(find.text('Request\nLeave'), findsOneWidget);
    });

    testWidgets('Worker View Member screen FAB opens WorkerLeaveRequestScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker'});
      UserService.currentRole = 'worker';

      await tester.pumpWidget(
        const MaterialApp(
          home: WorkerViewMemberScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(find.text('Request\nLeave'), findsOneWidget);
    });

    testWidgets('Worker Activity screen FAB opens WorkerLeaveRequestScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker'});
      UserService.currentRole = 'worker';

      await tester.pumpWidget(
        const MaterialApp(
          home: WorkerActivityScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(find.text('Request\nLeave'), findsOneWidget);
    });

    testWidgets('Worker Settings screen FAB opens WorkerLeaveRequestScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker'});
      UserService.currentRole = 'worker';

      await tester.pumpWidget(
        const MaterialApp(
          home: WorkerSettingsScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      expect(find.text('Request\nLeave'), findsOneWidget);
    });
  });
}
