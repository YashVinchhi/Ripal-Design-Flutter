import 'package:flutter_test/flutter_test.dart';
import 'package:ripaldesign/main.dart';

void main() {
  testWidgets('Worker Dashboard smoke test and visual element verification',
      (WidgetTester tester) async {
    // Build the Ripal Design app
    await tester.pumpWidget(const RipalDesignApp());
    await tester.pumpAndSettle();

    // Verify header branding
    expect(find.text('Ripal Design'), findsOneWidget);

    // Verify Greeting
    expect(find.text('Welcome, Rachit'), findsOneWidget);

    // Verify Statistics
    expect(find.text('ACTIVE PROJECTS'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
    expect(find.text('TEAM VELOCITY'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);

    // Verify Assigned Projects
    expect(find.text('Assigned Projects'), findsOneWidget);
    expect(find.text('Skyline Plaza'), findsOneWidget);

    // Verify Quick Actions
    expect(find.text('Quick Actions'), findsOneWidget);
    expect(find.text('VIEW PROJECT'), findsOneWidget);
    expect(find.text('UPLOAD FILES'), findsOneWidget);
    expect(find.text('TEAM VIEW'), findsOneWidget);
    expect(find.text('FILE VIEWS'), findsOneWidget);
    expect(find.text('LEAVE MANGE'), findsOneWidget);
    expect(find.text('ACTIVITY'), findsOneWidget);

    // Verify Bottom Navigation items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Leave'), findsOneWidget);
    expect(find.text('Upload'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Tap on Leave to test navigation to Leave History
    await tester.tap(find.text('Leave'));
    await tester.pumpAndSettle();
    expect(find.text('Leave History'), findsOneWidget);
    expect(find.text('BALANCE'), findsOneWidget);
    expect(find.text('12 Days'), findsOneWidget);

    // Tap on Profile to test navigation to Settings
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('ACCOUNT'), findsOneWidget);
    expect(find.text('NOTIFICATIONS'), findsOneWidget);

    // Tap on Profile Information to navigate to Edit Profile
    await tester.tap(find.text('Profile Information'));
    await tester.pumpAndSettle();
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Save Profile'), findsOneWidget);
  });
}
