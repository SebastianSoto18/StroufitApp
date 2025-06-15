import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFEFCFF),
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
    textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: AppTheme.textTittle,
    ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSubTittle,
          ),
    ),


        elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
    backgroundColor: AppTheme.primary,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    fontSize: 16,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    ),
    dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),),
    );
  }
}
