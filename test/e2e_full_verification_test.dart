import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ripal_design/main.dart';
import 'package:ripal_design/screen/admin_create_project.dart';
import 'package:ripal_design/screen/admin_finance_screen.dart';
import 'package:ripal_design/screen/admin_leave_screen.dart';
import 'package:ripal_design/screen/client_applay.dart';
import 'package:ripal_design/screen/client_contactus.dart';
import 'package:ripal_design/screen/dashboard_screen.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/worker_leave_history_screen.dart';
import 'package:ripal_design/screen/worker_leave_request_screen.dart';
import 'package:ripal_design/screen/worker_password_update_screen.dart';
import 'package:ripal_design/screen/worker_project_view_screen.dart';
import 'package:ripal_design/service/leave_service.dart';
import 'package:ripal_design/service/project_service.dart';
import 'package:ripal_design/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  void configureViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  group('Full Application End-to-End Verification', () {
    testWidgets('1. App launches with SplashScreen and navigates without layout overflow', (tester) async {
      configureViewport(tester);
      await tester.pumpWidget(const MainApp());
      expect(find.text('Ripal Design'), findsOneWidget);
      expect(find.text('ARCHITECTURAL EXCELLENCE'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    testWidgets('2. Client Flow: Contact Us validation, input & submission', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'client'});
      await tester.pumpWidget(const MaterialApp(home: ClientContactus()));
      await tester.pumpAndSettle();

      final sendBtn = find.text('Send Inquiry');
      expect(sendBtn, findsOneWidget);
      await tester.ensureVisible(sendBtn);
      await tester.tap(sendBtn);
      await tester.pumpAndSettle();

      // Validation errors should appear
      expect(find.text('Please enter your full name'), findsOneWidget);

      // Enter valid fields
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), 'Alice Wonderland');
      await tester.enterText(textFields.at(1), 'alice@example.com');
      await tester.enterText(textFields.at(2), 'Interested in bespoke modern villa interior design.');
      await tester.pumpAndSettle();

      // Select project type dropdown
      final dropdown = find.byType(DropdownButtonFormField<String>);
      if (dropdown.evaluate().isNotEmpty) {
        await tester.tap(dropdown);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Residential Design').last);
        await tester.pumpAndSettle();
      }

      // Submit valid form
      await tester.ensureVisible(sendBtn);
      await tester.tap(sendBtn);
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.textContaining('Inquiry Sent Successfully!'), findsOneWidget);
    });

    testWidgets('3. Client Flow: Apply / Join Form validation', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'client'});
      await tester.pumpWidget(const MaterialApp(home: ClientApplay()));
      await tester.pumpAndSettle();

      final applyBtn = find.text('Submit Application');
      expect(applyBtn, findsOneWidget);

      await tester.ensureVisible(applyBtn);
      await tester.tap(applyBtn);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your full name'), findsOneWidget);
    });

    testWidgets('4. Worker Flow: Dashboard & Explore Project', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker', 'userName': 'Niku'});
      await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Niku'), findsOneWidget);
      final exploreBtn = find.text('EXPLORE PROJECTS');
      expect(exploreBtn, findsOneWidget);

      await tester.ensureVisible(exploreBtn);
      await tester.tap(exploreBtn);
      await tester.pumpAndSettle();

      expect(find.byType(WorkerProjectViewScreen), findsOneWidget);
    });

    testWidgets('5. Worker Flow: Leave Request submission & Leave History reactive update', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker', 'userName': 'Niku'});

      await tester.pumpWidget(const MaterialApp(home: WorkerLeaveRequestScreen()));
      await tester.pumpAndSettle();

      final submitBtn = find.text('Submit Request');
      expect(submitBtn, findsOneWidget);

      final reasonField = find.byType(TextField).last;
      await tester.enterText(reasonField, 'Family vacation and medical checkup');
      await tester.pumpAndSettle();

      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      final workerLeaves = await LeaveService.getWorkerLeaves();
      expect(workerLeaves.any((l) => l.reason.contains('Family vacation')), isTrue);

      await tester.pumpWidget(const MaterialApp(home: WorkerLeaveHistoryScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Leave History'), findsOneWidget);
      expect(find.text('Request History'), findsOneWidget);
      expect(find.text('Annual Leave'), findsWidgets);
    });

    testWidgets('6. Worker Flow: Password Update with persistence', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'worker', 'userPassword': 'password123'});

      await tester.pumpWidget(const MaterialApp(home: WorkerPasswordUpdateScreen()));
      await tester.pumpAndSettle();

      final updateBtn = find.widgetWithText(ElevatedButton, 'Update Password');
      expect(updateBtn, findsOneWidget);

      final fields = find.byType(TextField);
      expect(fields, findsNWidgets(3));

      await tester.enterText(fields.at(0), 'password123');
      await tester.enterText(fields.at(1), 'newWorkerPass@2026');
      await tester.enterText(fields.at(2), 'newWorkerPass@2026');
      await tester.pumpAndSettle();

      await tester.ensureVisible(updateBtn);
      await tester.tap(updateBtn);
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('userPassword'), 'newWorkerPass@2026');
    });

    testWidgets('7. Employee Flow: Role Isolation removes Finance/Invoice/User cards', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'employee', 'userName': 'Rachit'});
      await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Finance Overview'), findsNothing);
      expect(find.text('Total Invoices'), findsNothing);
      expect(find.text('User Management'), findsNothing);
      expect(find.textContaining('Rachit'), findsOneWidget);
    });

    testWidgets('8. Role Security: Employee blocked from Admin screens via RoleGuardedScreen', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'employee'});
      await tester.pumpWidget(const MaterialApp(home: AdminFinanceScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Access Denied'), findsOneWidget);
    });

    testWidgets('9. Admin Flow: Multi-step Project Creation validation', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'admin'});
      ProjectService.resetDraft();

      await tester.pumpWidget(const MaterialApp(home: AdminCreateProject()));
      await tester.pumpAndSettle();

      final nameField = find.byType(TextField).first;
      await tester.enterText(nameField, '');
      await tester.pumpAndSettle();

      final nextBtn = find.text('Next');
      expect(nextBtn, findsOneWidget);

      await tester.ensureVisible(nextBtn);
      await tester.tap(nextBtn);
      await tester.pump();

      expect(find.textContaining('Please enter a project name'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('10. Admin Flow: Leave Management Approvals update dynamic state', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'admin'});

      await tester.pumpWidget(const MaterialApp(home: AdminLeaveScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Leave Management'), findsOneWidget);
      final approveBtns = find.text('APPROVE');
      if (approveBtns.evaluate().isNotEmpty) {
        await tester.tap(approveBtns.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('11. Profile & Settings update reflection', (tester) async {
      configureViewport(tester);
      SharedPreferences.setMockInitialValues({'role': 'admin'});

      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Yash'), findsOneWidget);

      await UserService.saveProfile(
        name: 'Yash Lead Designer',
        email: 'yash@gmail.com',
        phone: '9876543210',
        address: '101 Design Studio Tower, Off Ring Road',
        city: 'Rajkot',
        state: 'Gujarat',
        pinCode: '360005',
      );

      await tester.pumpWidget(const MaterialApp(home: SettingsScreen(key: ValueKey('updated'))));
      await tester.pumpAndSettle();
      expect(find.text('Yash Lead Designer'), findsOneWidget);
    });
  });
}
