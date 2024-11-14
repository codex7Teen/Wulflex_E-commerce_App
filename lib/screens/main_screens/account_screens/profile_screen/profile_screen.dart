import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLightTheme? AppColors.lightGreyThemeColor : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'PROFILE'),
      body: Text(';'),
    );
  }
}