import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

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
      color: AppColors.whiteThemeColor,
      letterSpacing: 1,
      fontWeight: FontWeight.bold);

//! CUSTOM GREEN BUTTON TEXT
  static final TextStyle customGreenButtonText = GoogleFonts.robotoCondensed(
      fontSize: 18,
      color: AppColors.whiteThemeColor,
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
          fontSize: 25.5,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 3,
          fontWeight: FontWeight.w600);

//! SEARCHBAR HINT TEXT
  static final TextStyle searchBarHintText =
      GoogleFonts.robotoCondensed(fontSize: 17, color: AppColors.darkishGrey);

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

//! ITEM-CARD BRAND TEXT (ITEM BRAND)
  static final TextStyle itemCardBrandText = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      color: AppColors.blackThemeColor,
      fontSize: 17.5,
      letterSpacing: 1);

  //! ITEM-CARD PRODUCT NAME TEXT (ITEM NAME)
  static final TextStyle itemCardNameText = GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.greyThemeColor,
    fontSize: 12.5,
    letterSpacing: 0.8,
  );

  //! ITEM-CARD DELETE CONTAINER TEXT
  static final TextStyle itemCardDeleteContainerText =
      GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.darkishGrey,
    fontSize: 14,
    letterSpacing: 0.8,
  );

//! ITEM-CARD SUB-TITLE TEXT (PRICE)
  static final TextStyle itemCardSubTitleText = GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.greenThemeColor,
    fontSize: 16.5,
    letterSpacing: 0.2,
  );

//! ITEM-CARD Third SUB-TITLE TEXT (percentade)
  static final TextStyle itemCardThirdSubTitleText =
      GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.w500,
    color: AppColors.greenThemeColor,
    fontSize: 14,
    letterSpacing: 0,
  );

  //! ITEM-CARD SECOND SUB-TITLE TEXT (retail PRICE)
  static final TextStyle itemCardSecondSubTitleText =
      GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.bold,
          color: AppColors.greyThemeColor,
          fontSize: 14,
          letterSpacing: 0.2,
          decoration: TextDecoration.lineThrough,
          decorationColor: AppColors.greyThemeColor,
          decorationThickness: 1);

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
  static TextStyle snackBarText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          fontSize: 16,
          color: isLightTheme(context)
              ? AppColors.whiteThemeColor
              : AppColors.blackThemeColor,
          letterSpacing: 0.4,
          fontWeight: FontWeight.bold);

  //! VIEW PRODUCT HEADING TEXT
  static TextStyle viewProductTitleText(BuildContext context) =>
      GoogleFonts.bebasNeue(
          textStyle: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: isLightTheme(context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor));

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

//! ORIGINAL PRICE TEXT
  static final TextStyle originalPriceText = GoogleFonts.bebasNeue(
      fontSize: 16,
      color: AppColors.darkishGrey,
      letterSpacing: 1.5,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.lineThrough,
      decorationColor: AppColors.darkishGrey,
      decorationThickness: 1);

//! OFFER PERCENTAGE TEXT
  static final TextStyle offerPercentageText = GoogleFonts.bebasNeue(
    fontSize: 18,
    color: AppColors.greenThemeColor,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w600,
  );

  //! DESCRIPTION TEXT
  static TextStyle descriptionText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.darkishGrey
                  : AppColors.lightGreyThemeColor));

  //! READ MORE & READ LESS TEXT
  static TextStyle readmoreAndreadLessText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.darkishGrey
                  : AppColors.lightGreyThemeColor));

  //! APPBAR TEXT BIG SIZED
  static TextStyle appbarTextBig(BuildContext context) => GoogleFonts.bebasNeue(
      fontSize: 32,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.blackThemeColor
          : AppColors.whiteThemeColor,
      letterSpacing: 3,
      fontWeight: FontWeight.w600);

//! HEY USER WELCOME TEXT
  static TextStyle heyUserWelcomeText(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 28,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 3,
          fontWeight: FontWeight.w600);

  //! SCREEN SUB HEADINGS
  static TextStyle screenSubHeadings(BuildContext context,
          {bool? fixedBlackColor = false}) =>
      GoogleFonts.bebasNeue(
          fontSize: 22,
          color: fixedBlackColor!
              ? AppColors.blackThemeColor
              : isLightTheme(context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor,
          letterSpacing: 1,
          fontWeight: FontWeight.w600);

  //! SCREEN SUB TITLES
  static final TextStyle screenSubTitles = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      color: AppColors.blackThemeColor,
      fontSize: 18,
      letterSpacing: 0.5);

  //! EDIT SCREEN SUB HEADINGS
  static TextStyle editScreenSubHeadings(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 22,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 1,
          fontWeight: FontWeight.w600);

  //! EDIT SCREEN TEXT FIELD STYLES
  static TextStyle editScreenTextfieldStyles(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: AppColors.blackThemeColor,
              fontWeight: FontWeight.bold,
              fontSize: 20));

  //! ADDRESS SCREEN TEXT FIELD STYLES
  static TextStyle addressScreenTextfieldStyles(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: isLightTheme(context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              fontSize: 17.5));

  //! ADDRESS SCREEN TEXT FIELD HINT STYLES
  static TextStyle addressScreenTextfieldHintStyles(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: AppColors.greyThemeColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              fontSize: 17.5));

  //! EDIT SCREEN HINT TEXT STYLE
  static TextStyle editScreenHinttextStyles(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: AppColors.greyThemeColor,
              fontWeight: FontWeight.w500,
              fontSize: 15));

  //! CUSTOM BLACK BUTTON TEXT
  static TextStyle customBlackButtonText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          fontSize: 18,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.whiteThemeColor
              : AppColors.blackThemeColor,
          letterSpacing: 1,
          fontWeight: FontWeight.bold);

  //! DELETE ACCOUNT RED WARNING TEXT
  static TextStyle delteAccountRedWarningText = GoogleFonts.robotoCondensed(
      textStyle: TextStyle(
          color: Colors.red[400], fontSize: 14.8, letterSpacing: 0.35));

  //! DELETE ACCOUNT CONFIRM TITLE
  static TextStyle pleaseConfirmText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: isLightTheme(context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor,
              fontSize: 21,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold));

  //! DELETE ACCOUNT CONFIRMATION LINES
  static TextStyle confimationLinesText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: isLightTheme(context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor,
              fontSize: 16.4,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w500));

  //! DELETE ACCOUNT ACNOWLEDGET TEXT GREY COLO
  static TextStyle deleteAccountAcknowledgeText = GoogleFonts.robotoCondensed(
      textStyle: TextStyle(
          color: AppColors.greyThemeColor, fontSize: 15, letterSpacing: 0.4));

  //! SEARCHBAR TEXT STYLE
  static final TextStyle searchBarTextStyle = GoogleFonts.robotoCondensed(
      fontSize: 18, color: AppColors.blackThemeColor);

  //! EMPTY PRODUCTS MESSAGE TEXT STYLE
  static TextStyle emptyProductsMessageText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          fontSize: 20,
          color: isLightTheme(context)
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 1);

  //! SEARCHFILTER HEADING TEXT STYLE
  static TextStyle searchFilterHeading(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 17.5,
          color: isLightTheme(context)
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 1);

  //! ALL CATEGORIES PAGE CATEGORY TEXT STYLE
  static TextStyle allCategoriesPageCategoryText(BuildContext context) =>
      GoogleFonts.bebasNeue(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          fontSize: 17);

  //! CART SUBTOTAL AND DISCOUNT
  static final TextStyle cartSubtotalAndDiscountText =
      GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.hardLightGeryThemeColor,
    fontSize: 16,
    letterSpacing: 1,
  );

  //! CART SUBTOTAL AND DISCOUNT AMOUNT (PRICE)
  static final TextStyle cartSubtotalAndDiscountAmountStyle =
      GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.w600,
    color: AppColors.greyThemeColor,
    fontSize: 16,
    letterSpacing: 0.7,
  );

  //! CART TOTOAL TEXT
  static final TextStyle cartTotalText = GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.blackThemeColor,
    fontSize: 16.5,
    letterSpacing: 1,
  );

  //! CART TOTOAL AMOUNT TEXT
  static final TextStyle cartTotalAmountText = GoogleFonts.robotoCondensed(
    fontWeight: FontWeight.bold,
    color: AppColors.greenThemeColor,
    fontSize: 17,
    letterSpacing: 0.5,
  );

  //! BUTTON CARDS TEXT
  static final TextStyle buttonCardsText = GoogleFonts.robotoCondensed(
      textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.5,
          letterSpacing: 0.8,
          color: AppColors.blackThemeColor));

  //! ADDRESS SELECT BUTTON TEXT IN ORDER SUMMARY
  static final TextStyle selectAddressText = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      color: AppColors.blackThemeColor,
      fontSize: 14,
      letterSpacing: 1);

  //! ADDRESS LIST ALL LIST ITEMS TEXT
  static TextStyle addressListItemsText(BuildContext context,
          {bool? fixedBlackColor = false}) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 0.3,
              color: fixedBlackColor!
                  ? AppColors.blackThemeColor
                  : isLightTheme(context)
                      ? AppColors.blackThemeColor
                      : AppColors.whiteThemeColor));

  //! ADDRESS LIST ADDRESS NAME TEXT
  static TextStyle addressNameText(BuildContext context) =>
      GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              letterSpacing: 0.35,
              color: isLightTheme(context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor));

  //! EMPTY SCREEN TEXT
  static TextStyle emptyScreenText(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 20,
          color: isLightTheme(context)
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 1);

  //! PAYMENT PAGE TOTOAL AMOUNT TEXT
  static final TextStyle paymentPageTotalAmountText = GoogleFonts.bebasNeue(
    fontWeight: FontWeight.bold,
    color: AppColors.greenThemeColor,
    fontSize: 20,
    letterSpacing: 1.5,
  );

  //! ORDER CONFIRMED TEXT BIGGG
  static TextStyle orderConfirmedTextBig(BuildContext context) =>
      GoogleFonts.bebasNeue(
          fontSize: 34,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
          letterSpacing: 2.5,
          fontWeight: FontWeight.w600);

//! MY ORDERS SCREEN MINI TEXT
  static final TextStyle myOrdersScreenMiniText = GoogleFonts.robotoCondensed(
      fontSize: 15, color: AppColors.darkishGrey, letterSpacing: 0.4);
}
