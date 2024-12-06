import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/home_screens/widgets/theme_toggle_widget.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'SETTINGS', 0.155),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 18, right: 18, bottom: 18),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.lightGreyThemeColor,
                  borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  Column(
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
                  SizedBox(width: 8),
                  Text(
                    'APP THEME',
                    style: AppTextStyles.buttonCardsText,
                  ),
                  Spacer(),
                  Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: AppColors.greenThemeColor,
                          borderRadius: BorderRadius.circular(18)),
                      child: ThemeToggleSwitchWidget(
                          isLightTheme: isLightTheme(context))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
