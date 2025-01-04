import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/features/account/presentation/screens/my_orders_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class OrderSuccessScreenWidgets {
  static PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text('THANK YOU',
          style: AppTextStyles.appbarTextBig(context).copyWith(fontSize: 26)),
      centerTitle: true,
    );
  }

  static Widget buildLottieAnimation() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 305),
        child: Lottie.asset('assets/lottie/order_success_lottie.json',
            width: 230, repeat: false),
      ),
    );
  }

  static Widget buildOrderConfirmedText(BuildContext context) {
    return Text('ORDER CONFIRMED !',
        style: AppTextStyles.orderConfirmedTextBig(context));
  }

  static Widget buildOrderPlacedSuccessText(BuildContext context) {
    return Text(
      'Your order has been placed successfully.',
      style: GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.w500,
        color: AppColors.greyThemeColor,
        fontSize: 14,
        letterSpacing: 1,
      ),
    );
  }

  static Widget buildTrackOrderRowWithText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You can track your orders here. ',
          style: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.w500,
            color: AppColors.greyThemeColor,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        GestureDetector(
          onTap: () => NavigationHelper.navigateToWithReplacement(
              context,
              const ScreenMyOrders(
                isBackButtonVisible: false,
              )),
          child: Text(
            'Track my order',
            style: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.bold,
              color: AppColors.greenThemeColor,
              fontSize: 14.5,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildContinueButton(BuildContext context) {
    return GreenButtonWidget(
        onTap: () {
          currentIndex = 0;
          NavigationHelper.navigateToWithReplacement(context, const MainScreen());
        },
        buttonText: 'Continue Shopping',
        borderRadius: 25,
        width: 1);
  }
}
