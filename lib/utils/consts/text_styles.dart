import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

class AppTextStyles {
  //! SPLASH SCREEN HEADINGS
  static final TextStyle introScreenHeading = GoogleFonts.bebasNeue(
      fontSize: 40, color: Colors.white, letterSpacing: 1);

  //! INTRO SCREEN SUB HEADINGS
  static final TextStyle introScreenSubheading = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.grey,
      letterSpacing: 1);

//! INTRO SCREEN SKIP BUTTON
  static final TextStyle introScreenSkipButton = GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: Colors.white,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

//! CUSTOM GREEN BUTTON TEXT
  static final TextStyle customGreenButtonText = GoogleFonts.robotoCondensed(
      fontSize: 18,
      color: Colors.white,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

//! AUTHENTICATION PAGES HEADINGS
  static final TextStyle authenticationHeadings = GoogleFonts.bebasNeue(
      fontSize: 40, color: Colors.black, letterSpacing: 1);

//! AUTHENTICATION TEXTFIELD STYLES
  static final TextStyle authenticationTextfieldStyle =
      GoogleFonts.robotoCondensed(
          fontSize: 18,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
          color: Colors.black);

//! AUTHENTICATION HINT TEXT
  static final TextStyle authenticationHintTextStyle =
      GoogleFonts.robotoCondensed(
          fontSize: 16,
          color: Colors.grey,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400);

//! FORGOT PASSWORD TEXT
  static final TextStyle forgotPasswordStyle = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: AppColors.greenThemeColor,
      letterSpacing: 1);

//! GOOGLE BUTTON TEXT
  static final TextStyle googleButtonStyle = GoogleFonts.robotoCondensed(
      fontSize: 18,
      color: Colors.black,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

//! NEW OR ALREADY HAVE ACC. TEXT (BOTH LOGIN AND SIGNUP SCREENS)
  static final TextStyle newToWulflexOrAlreadyHaveAccountText =
      GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.grey,
          letterSpacing: 1);

//! SIGN UP OR LOGIN TEXT (BOTH LOGIN AND SIGNUP SCREENS)
  static final TextStyle signUpAndLoginGreenText = GoogleFonts.robotoCondensed(
      fontSize: 17,
      color: AppColors.greenThemeColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 1);

//! OR DIVIDER TEXT IN LOGIN SCREEN
  static final TextStyle orDividerText = GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: AppColors.greyThemeColor,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

//! TERMS AND CONDITION BASE TEXT
  static final TextStyle termsAndConditionAndPrivacyPolicyBaseText =
      GoogleFonts.robotoCondensed(
          fontSize: 14, color: Colors.grey, letterSpacing: 0.6);

//! TERMS AND CONDITION GREEN TEXT
  static final TextStyle termsAndConditionAndPrivacyPolicyGreenText =
      GoogleFonts.robotoCondensed(
          fontSize: 14,
          color: AppColors.greenThemeColor,
          letterSpacing: 1,
          fontWeight: FontWeight.bold);

//! FORGOT PASSWORD DESCRIPTION TEXT
  static final TextStyle forgotPasswordDescriptionText =
      GoogleFonts.robotoCondensed(
          color: AppColors.blackThemeColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1);

//! HOME EXPLORE TEXT BIG.
  static TextStyle exploreTextStyle(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 28,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 3,
          fontWeight: FontWeight.w600);

//! MAIN SCREEN HEADINGS
  static TextStyle mainScreenHeadings(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 26,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 3,
          fontWeight: FontWeight.w600);

//! SEARCHBAR HINT TEXT
  static final TextStyle searchBarHintText =
      GoogleFonts.robotoCondensed(fontSize: 18, color: AppColors.darkishGrey);

//! CAROUSEL TITLE
  static final TextStyle carouselTitleText = GoogleFonts.bebasNeue(
      color: AppColors.whiteThemeColor,
      letterSpacing: 2,
      fontSize: 28,
      fontWeight: FontWeight.w600);

//! CAROUSEL SUB-TITLE
  static final TextStyle carouselSubTitleText = GoogleFonts.bebasNeue(
      fontSize: 20, color: AppColors.whiteThemeColor, letterSpacing: 1);

//! CAROUSEL SHOP NOW BUTTON TEXT
  static final TextStyle carouselShopNowText = GoogleFonts.bebasNeue(
      fontSize: 16, color: AppColors.blackThemeColor, letterSpacing: 1);

//! ALL MINI CIRCLED CATEGORIES TEXT
  static TextStyle allMiniCircledCategoriesText(BuildContext context) =>
      GoogleFonts.bebasNeue(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          fontSize: 13.5);

//! ITEM-CARD TITLE TEXT (ITEM NAME)
  static final TextStyle itemCardTitleText = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      color: AppColors.blackThemeColor,
      fontSize: 16,
      letterSpacing: 1);

//! ITEM-CARD SUB-TITLE TEXT (PRICE)
  static final TextStyle itemCardSubTitleText = GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.darkishGrey,
    fontSize: 18,
    letterSpacing: 1,
  );

//! VIEW PRODUCT MAIN HEADING
  static TextStyle viewProductMainHeading(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 32,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 3,
          fontWeight: FontWeight.w600);

//! VIEW PRODUCT RATINGS TEXT
  static final TextStyle viewProductratingsText = GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: AppColors.greyThemeColor,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400);

//! BOTTOM NAVBAR TEXT
  static TextStyle bottomNavigationBarText(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 2);

//! SNACKBAR TEXT
  static final TextStyle snackBarText = GoogleFonts.robotoCondensed(
      fontSize: 14,
      color: AppColors.whiteThemeColor,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400);

  //! SIZE HEADING TEXT
  static final TextStyle sizeHeadingText = GoogleFonts.robotoCondensed(
      textStyle: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.5));

  //! SIZE CHART TEXT
  static final TextStyle sizeChartText = GoogleFonts.robotoCondensed(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.greenThemeColor));

  //! OFFER PRICE HEADING TEXT
  static final TextStyle offerPriceHeadingText = GoogleFonts.bebasNeue(
      fontSize: 28,
      color: AppColors.greenThemeColor,
      letterSpacing: 1.5,
      fontWeight: FontWeight.w600);
}
