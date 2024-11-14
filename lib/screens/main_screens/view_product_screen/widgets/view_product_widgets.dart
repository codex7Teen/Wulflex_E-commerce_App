import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_weightandsize_selector_container_widget.dart';

PreferredSizeWidget buildAppBarWithIcons(BuildContext context) {
  final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

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
                      color: isLightTheme
                          ? AppColors.whiteThemeColor
                          : AppColors.blackThemeColor),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: isLightTheme
                          ? AppColors.blackThemeColor
                          : AppColors.whiteThemeColor),
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
                    color: isLightTheme
                        ? AppColors.whiteThemeColor
                        : AppColors.blackThemeColor),
                child: Center(
                  child: LikeButton(
                    likeBuilder: (isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked
                            ? Colors.pinkAccent
                            : isLightTheme
                                ? AppColors.blackThemeColor
                                : AppColors.whiteThemeColor,
                        size: 28,
                      );
                    },
                    circleColor: CircleColor(
                        start: isLightTheme
                            ? AppColors.blackThemeColor
                            : AppColors.whiteThemeColor,
                        end: isLightTheme
                            ? AppColors.blackThemeColor
                            : AppColors.whiteThemeColor),
                    bubblesColor: BubblesColor(
                        dotPrimaryColor: AppColors.blueThemeColor,
                        dotSecondaryColor: isLightTheme
                            ? AppColors.blackThemeColor
                            : AppColors.whiteThemeColor),
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

Widget buildItemImageSlider(
    BuildContext context, PageController pageController) {
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

Widget buildPageIndicator(PageController pageController, BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return SmoothPageIndicator(
    controller: pageController,
    count: 3,
    effect: ExpandingDotsEffect(
        activeDotColor: AppColors.greenThemeColor,
        dotColor: isLightTheme
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        dotHeight: 8,
        dotWidth: 8),
  );
}

Widget buildProductHeadingText(BuildContext context) {
  return Text('LOREM IPSUM SYNTHESIS, BLACK',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.viewProductMainHeading(context));
}

Widget buildRatingsContainer() {
  return Container(
    width: 198,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.lightGreyThemeColor),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: [
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.lightGreyThemeColor, size: 20),
        SizedBox(width: 8),
        Text(
          '4.0 Ratings',
          style: AppTextStyles.viewProductratingsText,
        ),
      ],
    ),
  );
}

Widget buildSizeAndSizeChartText() {
  return Row(
    children: [
      Text(
        'SIZE',
        style: AppTextStyles.viewProductTitleText,
      ),
      Spacer(),
      Icon(
        Icons.straighten_outlined,
        color: AppColors.greenThemeColor,
      ),
      SizedBox(width: 6),
      Text(
        'Size Chart',
        style: AppTextStyles.sizeChartText,
      ),
    ],
  );
}

Widget buildWeightAndSizeSelectors(
    Set<String> selectedWeights,
    VoidCallback onSmallTapped,
    VoidCallback onMediumTapped,
    VoidCallback onLargeTapped) {
  return Row(
    children: [
      CustomWeightandsizeSelectorContainerWidget(
          weightOrSize: 'S',
          isSelected: selectedWeights.contains('S'),
          onTap: onSmallTapped),
      SizedBox(width: 10),
      CustomWeightandsizeSelectorContainerWidget(
          weightOrSize: 'M',
          isSelected: selectedWeights.contains('M'),
          onTap: onMediumTapped),
      SizedBox(width: 10),
      CustomWeightandsizeSelectorContainerWidget(
          weightOrSize: 'L',
          isSelected: selectedWeights.contains('L'),
          onTap: onLargeTapped),
    ],
  );
}

Widget buildPriceDetailsContainer(BuildContext context) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isLightTheme
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor),
    child: Row(
      children: [
        Text(
          "₹ 1099.00",
          style: AppTextStyles.offerPriceHeadingText,
        ),
        SizedBox(width: 14),
        Text(
          "₹ 3499.00",
          style: AppTextStyles.originalPriceText,
        ),
        SizedBox(width: 16),
        Text(
          "46% OFF",
          style: AppTextStyles.offerPercentageText,
        ),
        Spacer(),
        Icon(
          Icons.info,
          color: AppColors.darkishGrey,
        )
      ],
    ),
  );
}

Widget buildDescriptionTitle() {
  return Text("DESCRIPTION", style: AppTextStyles.viewProductTitleText);
}

Widget buildDescription(BuildContext context, bool isExpanded) {
  return Text(
      textAlign: TextAlign.justify,
      style: AppTextStyles.descriptionText(context),
      overflow: TextOverflow.fade,
      maxLines: isExpanded ? null : 5,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
}

Widget buildReammoreAndReadlessButton(
    bool isExpanded, VoidCallback onTap, BuildContext context) {
  return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: onTap,
        child: Text(isExpanded ? "Read Less" : "Read more",
            style: AppTextStyles.readmoreAndreadLessText(context)),
      ));
}

Widget buildAddToCartButton() {
  return GreenButtonWidget(
      buttonText: 'Add to cart', borderRadius: 25, width: 1);
}
