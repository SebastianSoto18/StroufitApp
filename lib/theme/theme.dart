import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFC9C9FF);
  static const Color secondary = Color(0xFFFFB3BA);
  static const Color tertiary = Color(0xFFB5EAD7);
  static const Color background = Color(0xFFFFF9F5);
  static const Color textTittle = Color(0xFF444444);
  static const Color textSubTittle = Color(0xFF777777);
  static const Color textPrimary = Color(0xFF838383);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppTheme.background,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textSubTittle,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 24),
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins',
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
