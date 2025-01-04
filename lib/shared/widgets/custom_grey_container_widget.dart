import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

class CustomGreyContainerWidget extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final IconData icon;
  const CustomGreyContainerWidget({super.key, required this.titleText, required this.subtitleText, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                titleText,
                style: AppTextStyles.screenSubHeadings(context, fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              Column(
                children: [
                  Icon(icon,
                      color: AppColors.blackThemeColor, size: 22),
                  const SizedBox(height: 2)
                ],
              )
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitleText,
            style: AppTextStyles.screenSubTitles,
          )
        ],
      ),
    );
  }
}
