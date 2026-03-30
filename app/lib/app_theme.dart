import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color kNavy = Color(0xFF020617);
  static const Color kDeepNavy = Color(0xFF0F172A);
  static const Color kGold = Color(0xFFFCD116);
  static const Color kBlue = Color(0xFF0038A8);

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: kBlue,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
  );

  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kNavy,
    colorSchemeSeed: kGold,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
  );
}