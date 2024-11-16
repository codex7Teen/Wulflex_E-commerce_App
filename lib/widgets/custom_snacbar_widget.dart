import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class CustomSnackbar {
  static void showCustomSnackBar(BuildContext context, String message, {IconData icon = Icons.done_outline_rounded}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isLightTheme(context) ? AppColors.whiteThemeColor : AppColors.blackThemeColor, size: 18,),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                overflow: TextOverflow.ellipsis,
                message,
                style: AppTextStyles.snackBarText(context),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        backgroundColor: isLightTheme(context) ? AppColors.blackThemeColor : AppColors.whiteThemeColor,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 9,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
