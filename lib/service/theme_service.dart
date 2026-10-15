import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String themePrefKey = 'is_dark_mode';
  static const String themeModeKey = 'theme_mode';

  static final ThemeService instance = ThemeService._();
  ThemeService._();

  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  ThemeMode get themeMode => themeModeNotifier.value;
  bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(themePrefKey) ??
        (prefs.getString(themeModeKey) == 'dark');
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    themeModeNotifier.value = newMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themePrefKey, newMode == ThemeMode.dark);
    await prefs.setString(
        themeModeKey, newMode == ThemeMode.dark ? 'dark' : 'light');
  }

  Future<void> setTheme(bool isDark) async {
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themePrefKey, isDark);
    await prefs.setString(themeModeKey, isDark ? 'dark' : 'light');
  }
}
