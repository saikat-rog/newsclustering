import 'package:flutter/material.dart';

class AppTheme {

  // Utility function for responsive font size
  static double responsiveFontSize(BuildContext context, double multiplier) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * multiplier;
    return size;
  }

  // Light theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF2563EB),
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),

      // Text theme with responsive font sizes and custom font
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: responsiveFontSize(context, 0.07),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1A1A),
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: responsiveFontSize(context, 0.05),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1A1A),
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: responsiveFontSize(context, 0.05),
          color: const Color(0xFF1A1A1A),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: responsiveFontSize(context, 0.04),
          color: const Color(0xFF1A1A1A),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: responsiveFontSize(context, 0.03),
          color: const Color(0xFF1A1A1A),
        ),
        bodySmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: responsiveFontSize(context, 0.028),
          color: const Color(0xFF1A1A1A),
        ),
      ),

      // Elevated button theme with custom font
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: responsiveFontSize(context, 0.05),
            color: const Color(0xFFFFFFFF),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}