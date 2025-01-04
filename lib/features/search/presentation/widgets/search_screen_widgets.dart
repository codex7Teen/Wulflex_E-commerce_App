import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class SearchScreenWidgets {
  static Widget buildSearchbarWithBackbutton(
      BuildContext context, double screenWidth, FocusNode focusNode,
      {required ValueChanged onChanged}) {
    return Row(
      children: [
        // Back Button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isLightTheme(context)
                ? AppColors.blackThemeColor
                : AppColors.whiteThemeColor,
          ),
        ),
        const SizedBox(width: 15),
        // Search Bar
        Expanded(
          child: Container(
            height: 50,
            width: screenWidth * 0.92,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.lightGreyThemeColor
                  : AppColors.whiteThemeColor,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Image.asset('assets/Search.png',
                    scale: 28, color: AppColors.darkishGrey),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    onChanged: onChanged,
                    style: AppTextStyles.searchBarTextStyle,
                    decoration: InputDecoration(
                      hintText: 'Search by product or category',
                      hintStyle: AppTextStyles.searchBarHintText,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildFilterDropdown(BuildContext context, String selectedFilter,
      {required ValueChanged onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        DropdownButton<String>(
          dropdownColor: isLightTheme(context)
              ? AppColors.whiteThemeColor
              : AppColors.darkishGrey,
          value: selectedFilter,
          borderRadius: BorderRadius.circular(18),
          items: [
            'Featured',
            'Price: Low to High',
            'Price: High to Low',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: AppTextStyles.searchFilterHeading(context)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  static Widget buildSearchedProductNotFoundDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 130),
          Lottie.asset('assets/lottie/search_empty_lottie_white.json',
              width: 190, repeat: false),
          SizedBox(height: 18),
          Text(
            'We couldn’t find what you’re looking for. Please refine your search.',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyScreenText(context),
          ),
        ],
      ),
    );
  }
}
