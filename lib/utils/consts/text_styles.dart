import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle headLineLarge = GoogleFonts.bebasNeue(
      fontSize: 40, color: Colors.white, letterSpacing: 1);

  static final TextStyle headLineMedium = GoogleFonts.bebasNeue(
      fontSize: 28,
      color: Colors.black,
      letterSpacing: 3,
      fontWeight: FontWeight.w600);

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

  static final TextStyle titleSmallBold = GoogleFonts.bebasNeue(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.black,
      letterSpacing: 2);
}
