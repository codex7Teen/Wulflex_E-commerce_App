import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenFavorite extends StatelessWidget {
  const ScreenFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('FAVORITES', style: AppTextStyles.appbarTextBig(context)),
      ),
      body: Center(
        child: Text('THIS IS FAVORITE SCREEN'),
      ),
    );
  }
}
