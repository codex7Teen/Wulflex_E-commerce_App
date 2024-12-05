import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/home_screens/category_screens/categorized_product_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

Widget buildCategoriesCard(
    BuildContext context,
    List<String> defaultCategoryImages,
    List<String> defaultCategoryNames,
    int index) {
  return GestureDetector(
    onTap: () {
      NavigationHelper.navigateToWithoutReplacement(context,
          ScreenCategorizedProduct(categoryName: defaultCategoryNames[index]));
    },
    child: GridTile(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 100,
              child: Image.asset(
                defaultCategoryImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )),
        const SizedBox(height: 8),
        Text(
          defaultCategoryNames[index],
          style: TextStyle(
            color: isLightTheme(context)
                ? AppColors.blackThemeColor
                : AppColors.whiteThemeColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    )),
  );
}
