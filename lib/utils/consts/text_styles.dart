import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle headLineLarge = GoogleFonts.bebasNeue(
      fontSize: 40, color: Colors.white, letterSpacing: 1);

  static final TextStyle titleSmall = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.grey,
      letterSpacing: 1);

  static final TextStyle titleSmallThin = GoogleFonts.robotoCondensed(
      fontSize: 16, color: Colors.grey, letterSpacing: 0.5);

  static final TextStyle titleXSmall = GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: Colors.white,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

  static final TextStyle titleXSmallThin = GoogleFonts.robotoCondensed(
      fontSize: 14, color: Colors.grey, letterSpacing: 0.6);

  static final TextStyle titleMedium = GoogleFonts.robotoCondensed(
      fontSize: 18,
      color: Colors.white,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

  static final TextStyle bodySmall = GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: Colors.white,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400);
}
