import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color(0xFF9E4723);
  static const Color primaryDark = Color(0xFFE07A5F);
  static const Color brandMaroon = Color(0xFF5A0000);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFF7F2),
    cardColor: Colors.white,
    dividerColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      secondary: brandMaroon,
      surface: Colors.white,
      onSurface: Color(0xFF2D2D2D),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: brandMaroon),
      titleTextStyle: TextStyle(
        color: brandMaroon,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF141212),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: const Color(0xFF2C2C2C),
    dialogTheme: const DialogThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      secondary: primaryDark,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
  );
}
