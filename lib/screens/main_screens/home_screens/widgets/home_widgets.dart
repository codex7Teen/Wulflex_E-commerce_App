import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

Widget buildExploreTextAndLogo() {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          'EXPLORE',
          style: AppTextStyles.headLineMedium,
        ),
      ),
      SizedBox(width: 14),
      Image.asset('assets/wulflex_logo_nobg.png', width: 30),
      Spacer(),
      Icon(Icons.person, color: AppColors.darkScaffoldColor, size: 28)
    ],
  );
}
