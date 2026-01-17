import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryGreen = Color(0xFF2E7D32);
  static const accentOrange = Color(0xFFFF9800);
  
  // Minimalist Colors for Dark Mode
  static const darkBackground = Color(0xFF121212);
  static const darkCard = Color(0xFF1E1E1E);
  static const darkBorder = Color(0xFF2C2C2C);
  static const darkTextTitle = Color(0xFFF5F5F7); // Apple-like white
  static const darkTextBody = Color(0xFF86868B);  // Apple-like gray

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF5F5F7), // Neutral light gray
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
      primary: primaryGreen,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: GoogleFonts.outfit(color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E5E7), width: 0.5),
      ),
      color: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
      primary: primaryGreen,
      surface: darkCard,
      onSurface: darkTextTitle,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: darkTextTitle),
      bodyMedium: GoogleFonts.outfit(color: darkTextBody),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: darkBackground,
      foregroundColor: darkTextTitle,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextTitle),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: darkBorder, width: 0.5),
      ),
      color: darkCard,
    ),
  );
}
