import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class CustomCategoriesContainerWidget extends StatelessWidget {
  final String iconImagePath;
  final String categoryTitleText;
  const CustomCategoriesContainerWidget({super.key, required this.iconImagePath, required this.categoryTitleText});

  @override
  Widget build(BuildContext context) {
    return Column(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.lightGreyThemeColor : AppColors.whiteThemeColor),
                        child: Center(
                            child:
                                Image.asset(iconImagePath, scale: 21)),
                      ),
                      SizedBox(height: 10),
                      Text(categoryTitleText,
                          style: AppTextStyles.allMiniCircledCategoriesText(context))
                    ],
                  );
  }
}