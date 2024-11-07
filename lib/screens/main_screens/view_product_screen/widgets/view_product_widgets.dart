import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

PreferredSizeWidget buildAppBarWithIcons(BuildContext context) {
  return AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteThemeColor),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteThemeColor),
                      child: Center(
                        child: LikeButton(
                          circleColor: CircleColor(
                              start: AppColors.blackThemeColor,
                              end: AppColors.blackThemeColor),
                          bubblesColor: BubblesColor(
                              dotPrimaryColor: AppColors.blueThemeColor,
                              dotSecondaryColor: AppColors.blackThemeColor),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
}

Widget buildItemImageSlider(BuildContext context, PageController pageController) {
  return SizedBox(
                height: 300,
                width: MediaQuery.sizeOf(context).width * 1,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/wulflex_logo_nobg.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ));
}

Widget buildPageIndicator(PageController pageController) {
  return SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.greenThemeColor,
                  dotColor: AppColors.whiteThemeColor,
                  dotHeight: 8,
                  dotWidth: 8),
            );
}

