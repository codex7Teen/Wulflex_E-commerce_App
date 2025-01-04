import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

class CustomCategoriesContainerWidget extends StatelessWidget {
  final String iconImagePath;
  final String categoryTitleText;
  final VoidCallback onTap;
  const CustomCategoriesContainerWidget(
      {super.key,
      required this.iconImagePath,
      required this.categoryTitleText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.lightGreyThemeColor
                    : AppColors.whiteThemeColor),
            child: Center(child: Image.asset(iconImagePath, scale: 21)),
          ),
          const SizedBox(height: 10),
          Text(categoryTitleText,
              style: AppTextStyles.allMiniCircledCategoriesText(context))
        ],
      ),
    );
  }
}
