import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class CategorizedProductScreenWidgets {
  static Widget buildEmptyProductDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 130),
          Lottie.asset('assets/lottie/search_empty_lottie_white.json',
              width: 190, repeat: false),
          const SizedBox(height: 18),
          Text(
            'We couldn’t find what you’re looking for. Please refine your search.',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyScreenText(context),
          ),
        ],
      ),
    );
  }

  static Widget buildSearchBar(BuildContext context, double screenWidth,
      ValueChanged onChanged, String categoryName) {
    return Container(
      height: 50,
      width: screenWidth * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: isLightTheme(context)
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Image.asset(
            'assets/Search.png',
            scale: 28,
            color: AppColors.darkishGrey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTextStyles.searchBarTextStyle,
              decoration: InputDecoration(
                hintText: 'Search for any ${categoryName.toLowerCase()}...',
                hintStyle: AppTextStyles.searchBarHintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
