import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color skyBlue = Color(0xFF8ECDF2);
final Color softIndigo = Color(0xFF6D8CB3);
final Color softMint = Color(0xFFBEE7D6);
final Color softPeach = Color(0xFFF9E0D9);
final Color surface = Color(0xFFF7FBFF);

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: skyBlue,
      primary: skyBlue,
      secondary: softMint,
      background: surface,
      surface: surface,
    ),
    scaffoldBackgroundColor: surface,
    textTheme: TextTheme(
      headlineSmall: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: GoogleFonts.poppins(fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withOpacity(0.6),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: softIndigo),
      surfaceTintColor: Colors.white,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}