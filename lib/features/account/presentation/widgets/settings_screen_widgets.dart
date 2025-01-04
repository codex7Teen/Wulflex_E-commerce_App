import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_toggle_widget.dart';

class SettingsScreenWidgets {
  static Widget buildAppthemeToggler(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.lightGreyThemeColor,
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.brightness_6_rounded,
                size: 24,
                color: AppColors.blackThemeColor,
              ),
              SizedBox(height: 3)
            ],
          ),
          const SizedBox(width: 8),
          Text(
            'APP THEME',
            style: AppTextStyles.buttonCardsText,
          ),
          const Spacer(),
          Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: AppColors.greenThemeColor,
                  borderRadius: BorderRadius.circular(18)),
              child:
                  ThemeToggleSwitchWidget(isLightTheme: isLightTheme(context))),
        ],
      ),
    );
  }
}
