import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/features/home/presentation/screens/home_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenOrderSuccess extends StatelessWidget {
  const ScreenOrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text('THANK YOU',
            style: AppTextStyles.appbarTextBig(context).copyWith(fontSize: 26)),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 305),
                child: Lottie.asset('assets/lottie/order_success_lottie.json',
                    width: 230, repeat: false),
              ),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ORDER CONFIRMED !',
                    style: AppTextStyles.orderConfirmedTextBig(context)),
                SizedBox(height: 10),
                Text(
                  'Your order has been placed successfully.',
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyThemeColor,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
                Row(
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
                    Text(
                      'Track my order',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold,
                        color: AppColors.greenThemeColor,
                        fontSize: 14.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                //! continue button
                GreenButtonWidget(
                    onTap: () {
                      currentIndex = 0;
                      NavigationHelper.navigateToWithReplacement(
                          context, MainScreen());
                    },
                    buttonText: 'Continue Shopping',
                    borderRadius: 25,
                    width: 1)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
