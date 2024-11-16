import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class CustomBlackButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final double borderRadius;
  const CustomBlackButtonWidget(
      {super.key,
      required this.buttonText,
      this.isLoading = false,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1,
        height: MediaQuery.sizeOf(context).height * 0.065,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: isLightTheme
                ? AppColors.blackThemeColor
                : AppColors.whiteThemeColor),
        child: Center(
          // show loading indication when some state is loading
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.whiteThemeColor,
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      size: 24,
                      color: isLightTheme
                          ? AppColors.whiteThemeColor
                          : AppColors.blackThemeColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      buttonText,
                      style: AppTextStyles.customBlackButtonText(context),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
