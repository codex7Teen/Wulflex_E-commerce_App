import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class ScreenSearchScreen extends StatelessWidget {
  const ScreenSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor:
          isLightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 15),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: isLightTheme
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
                        Image.asset(
                          'assets/Search.png',
                          scale: 28,
                          color: AppColors.darkishGrey,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Search...',
                          style: AppTextStyles.searchBarHintText,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            // Blank space below
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
