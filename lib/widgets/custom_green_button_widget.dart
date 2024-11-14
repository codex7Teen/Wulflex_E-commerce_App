import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class GreenButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final double borderRadius;
  final double? width;
  const GreenButtonWidget(
      {super.key, required this.buttonText, this.isLoading = false, required this.borderRadius, this.width = 0.89});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * width!,
        height: MediaQuery.sizeOf(context).height * 0.065,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: AppColors.greenThemeColor),
        child: Center(
          // show loading indication when some state is loading
          child: isLoading
              ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: AppColors.whiteThemeColor,))
              : Text(
                  buttonText,
                  style: AppTextStyles.customGreenButtonText,
                ),
        ),
      ),
    );
  }
}
