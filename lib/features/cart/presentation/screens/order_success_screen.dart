import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/cart/presentation/widgets/order_success_screen_widgets.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenOrderSuccess extends StatelessWidget {
  const ScreenOrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: OrderSuccessScreenWidgets.buildAppBar(context),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
        child: Stack(
          children: [
            OrderSuccessScreenWidgets.buildLottieAnimation(),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OrderSuccessScreenWidgets.buildOrderConfirmedText(context),
                const SizedBox(height: 10),
                OrderSuccessScreenWidgets.buildOrderPlacedSuccessText(context),
                OrderSuccessScreenWidgets.buildTrackOrderRowWithText(context),
                const SizedBox(height: 24),
                //! Continue button
                OrderSuccessScreenWidgets.buildContinueButton(context)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
