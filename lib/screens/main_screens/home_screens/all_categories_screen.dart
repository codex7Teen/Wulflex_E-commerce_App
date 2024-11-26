import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenAllCategories extends StatelessWidget {
  final String screenTitle;
  const ScreenAllCategories({super.key, required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, screenTitle, 0.080),
    );
  }
}
