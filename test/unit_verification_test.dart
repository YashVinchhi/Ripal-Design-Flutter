import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ripal_design/resource/role_guard.dart';
import 'package:ripal_design/service/leave_service.dart';
import 'package:ripal_design/service/project_service.dart';
import 'package:ripal_design/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Role Guard Verification', () {
    testWidgets('Blocks unauthorized user and displays Access Denied', (tester) async {
      SharedPreferences.setMockInitialValues({'role': 'worker'});

      await tester.pumpWidget(
        const MaterialApp(
          home: RoleGuardedScreen(
            allowedRoles: ['admin'],
            child: Text('Secret Admin Screen'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Secret Admin Screen'), findsNothing);
      expect(find.textContaining('Access Denied'), findsOneWidget);
    });

    testWidgets('Allows authorized user to access protected screen', (tester) async {
      SharedPreferences.setMockInitialValues({'role': 'worker'});

      await tester.pumpWidget(
        const MaterialApp(
          home: RoleGuardedScreen(
            allowedRoles: ['worker'],
            child: Text('Worker Screen Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Worker Screen Content'), findsOneWidget);
      expect(find.text('Access Denied'), findsNothing);
    });
  });

  group('LeaveService Verification', () {
    test('Can fetch leaves, add new leave record, and update status dynamically', () async {
      SharedPreferences.setMockInitialValues({});
      final initialLeaves = await LeaveService.getLeaves();
      final initialCount = initialLeaves.length;
      bool notified = false;
      void listener() {
        notified = true;
      }

      LeaveService.leaveUpdateNotifier.addListener(listener);

      final newRecord = LeaveRecord(
        id: 'test_leave_101',
        applicantName: 'Test Worker',
        applicantRole: 'Site Worker',
        leaveType: 'Annual Leave',
        dateRange: 'Nov 01 - Nov 05',
        duration: '5 days',
        status: 'PENDING',
        appliedDate: 'OCT 08, 2026',
        reason: 'Personal vacation',
      );

      await LeaveService.addLeave(newRecord);
      final updatedLeaves = await LeaveService.getLeaves();
      expect(updatedLeaves.length, initialCount + 1);
      expect(notified, isTrue);

      expect(updatedLeaves.first.applicantName, 'Test Worker');
      expect(updatedLeaves.first.status, 'PENDING');

      // Test status update
      await LeaveService.updateStatus('test_leave_101', 'APPROVED');
      final afterStatusUpdate = await LeaveService.getLeaves();
      expect(afterStatusUpdate.first.status, 'APPROVED');

      LeaveService.leaveUpdateNotifier.removeListener(listener);
    });
  });

  group('ProjectService Step Validation Verification', () {
    test('Enforces Step 1 validation', () {
      final draft = ProjectDraft();
      String? errorMessage;
      void onError(String msg) {
        errorMessage = msg;
      }

      // Empty draft -> invalid
      expect(ProjectService.validateStep1(draft, onError: onError), isFalse);
      expect(errorMessage, isNotNull);

      // Populate valid details
      draft.projectName = 'Luxury Villa 101';
      draft.timeline = '6 Months';
      draft.description = 'A premier contemporary residence designed with bespoke stone and glass.';
      draft.budget = '\$1,500,000';
      draft.ownerName = 'John Doe';
      draft.ownerEmail = 'john.doe@example.com';
      draft.ownerPhone = '9876543210';

      expect(ProjectService.validateStep1(draft, onError: onError), isTrue);
    });

    test('Enforces Step 2 team validation', () {
      final draft = ProjectDraft();
      String? errorMessage;
      void onError(String msg) {
        errorMessage = msg;
      }

      draft.teamMembers = [];
      expect(ProjectService.validateStep2(draft, onError: onError), isFalse);
      expect(errorMessage, 'Please assign or add at least one team member');

      draft.teamMembers = [
        {'name': 'Yash Vinchhi', 'role': 'Lead Architect', 'initials': 'YV'},
      ];
      expect(ProjectService.validateStep2(draft, onError: onError), isTrue);
    });

    test('Enforces Step 3 file validation', () {
      final draft = ProjectDraft();
      String? errorMessage;
      void onError(String msg) {
        errorMessage = msg;
      }

      draft.uploadedFiles = [];
      expect(ProjectService.validateStep3(draft, onError: onError), isFalse);
      expect(errorMessage, 'Please select at least one project file');

      draft.uploadedFiles = [
        {'filename': 'blueprint.dwg', 'progress': 1.0, 'progressText': '100%'},
      ];
      expect(ProjectService.validateStep3(draft, onError: onError), isTrue);
    });
  });

  group('UserService Profile and Auth Verification', () {
    test('Saves and loads profile data correctly', () async {
      SharedPreferences.setMockInitialValues({'role': 'worker'});

      await UserService.saveProfile(
        name: 'Sarah Connor',
        email: 'sarah@ripaldesign.com',
        phone: '+91 9876543210',
        address: 'Sector 5, Industrial Area',
        city: 'Ahmedabad',
        state: 'Gujarat',
        pinCode: '380015',
      );

      final profile = await UserService.getCurrentProfile();
      expect(profile.name, 'Sarah Connor');
      expect(profile.email, 'sarah@ripaldesign.com');
      expect(profile.phone, '+91 9876543210');
      expect(profile.city, 'Ahmedabad');
    });

    test('Updates password and persists to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});

      await UserService.updatePassword('newsecretpass123');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('userPassword'), 'newsecretpass123');
    });
  });
}
