import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ripal_design/main.dart';
import 'package:ripal_design/resource/app_theme.dart';
import 'package:ripal_design/resource/setting_tile.dart';
import 'package:ripal_design/screen/settings_screen.dart';
import 'package:ripal_design/screen/worker_settings_screen.dart';
import 'package:ripal_design/service/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Theme Direct One-Tap Toggle Verification', () {
    testWidgets('WorkerSettingsScreen: One-tap toggle directly switches Light <-> Dark mode', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      SharedPreferences.setMockInitialValues({'role': 'worker', 'is_dark_mode': false});
      await ThemeService.instance.init();

      await tester.pumpWidget(
        ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeService.instance.themeModeNotifier,
          builder: (context, mode, _) {
            return MaterialApp(
              themeMode: mode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const WorkerSettingsScreen(),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      // Initial state: Light Mode
      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('Light Mode'), findsOneWidget);
      expect(find.text('Dark Mode'), findsNothing);
      expect(ThemeService.instance.isDarkMode, isFalse);

      // Verify row has chevron '>'
      final themeTileFinder = find.ancestor(
        of: find.text('Theme'),
        matching: find.byType(SettingTile),
      );
      expect(themeTileFinder, findsOneWidget);
      expect(
        find.descendant(of: themeTileFinder, matching: find.byIcon(Icons.chevron_right)),
        findsOneWidget,
      );

      // TAP 1: Tap Theme tile row directly
      await tester.tap(themeTileFinder);
      await tester.pumpAndSettle();

      // Immediately switches to Dark Mode and subtitle updates to Dark Mode
      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('Light Mode'), findsNothing);
      expect(ThemeService.instance.isDarkMode, isTrue);

      // Check persistence in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('is_dark_mode'), isTrue);

      // TAP 2: Tap Theme tile row again
      await tester.tap(themeTileFinder);
      await tester.pumpAndSettle();

      // Immediately switches back to Light Mode and subtitle updates to Light Mode
      expect(find.text('Light Mode'), findsOneWidget);
      expect(find.text('Dark Mode'), findsNothing);
      expect(ThemeService.instance.isDarkMode, isFalse);
      expect(prefs.getBool('is_dark_mode'), isFalse);
    });

    testWidgets('SettingsScreen (Admin/Client): One-tap toggle directly switches Light <-> Dark mode', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      SharedPreferences.setMockInitialValues({'role': 'admin', 'is_dark_mode': false});
      await ThemeService.instance.init();

      await tester.pumpWidget(
        ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeService.instance.themeModeNotifier,
          builder: (context, mode, _) {
            return MaterialApp(
              themeMode: mode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const SettingsScreen(),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      // Verify Theme tile exists with Light Mode subtitle
      final themeTileFinder = find.ancestor(
        of: find.text('Theme'),
        matching: find.byType(SettingTile),
      );
      expect(themeTileFinder, findsOneWidget);
      expect(find.text('Light Mode'), findsOneWidget);

      // TAP 1: Tap Theme tile
      await tester.tap(themeTileFinder);
      await tester.pumpAndSettle();

      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('Light Mode'), findsNothing);
      expect(ThemeService.instance.isDarkMode, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('is_dark_mode'), isTrue);

      // TAP 2: Tap Theme tile back to Light Mode
      await tester.tap(themeTileFinder);
      await tester.pumpAndSettle();

      expect(find.text('Light Mode'), findsOneWidget);
      expect(find.text('Dark Mode'), findsNothing);
      expect(ThemeService.instance.isDarkMode, isFalse);
      expect(prefs.getBool('is_dark_mode'), isFalse);
    });

    testWidgets('Theme selection persists across app restart', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // Save dark mode preference beforehand (simulating restart)
      SharedPreferences.setMockInitialValues({'is_dark_mode': true, 'role': 'worker'});
      await ThemeService.instance.init();

      expect(ThemeService.instance.isDarkMode, isTrue);

      await tester.pumpWidget(const MainApp());
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // ThemeService in MainApp reflects dark theme
      expect(ThemeService.instance.themeMode, ThemeMode.dark);
    });
  });
}
