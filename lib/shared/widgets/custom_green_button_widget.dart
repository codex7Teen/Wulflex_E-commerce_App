import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

class GreenButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final double borderRadius;
  final double? width;
  final bool? addIcon;
  final IconData? icon;
  final VoidCallback? onTap;
  const GreenButtonWidget(
      {super.key,
      this.onTap,
      required this.buttonText,
      this.isLoading = false,
      required this.borderRadius,
      this.width = 0.89,
      this.addIcon = false,
      this.icon = Icons.ac_unit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
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
                    child: CircularProgressIndicator(
                      color: AppColors.whiteThemeColor,
                    ))
                : addIcon!
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon,
                              size: 24, color: AppColors.whiteThemeColor),
                          SizedBox(width: 8),
                          Text(
                            buttonText,
                            style: AppTextStyles.customGreenButtonText,
                          ),
                        ],
                      )
                    : Text(
                        buttonText,
                        style: AppTextStyles.customGreenButtonText,
                      ),
          ),
        ),
      ),
    );
  }
}
