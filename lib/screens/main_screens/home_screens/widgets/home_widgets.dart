import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/screens/main_screens/home_screens/widgets/theme_toggle_widget.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/view_product_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_categories_container_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

Widget buildExploreTextAndLogo(BuildContext context) {
  final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          'EXPLORE',
          style: AppTextStyles.exploreTextStyle(context),
        ),
      ),
      SizedBox(width: 14),
      Image.asset(
        'assets/wulflex_logo_nobg.png',
        width: 30,
        color: isLightTheme
            ? AppColors.blackThemeColor
            : AppColors.whiteThemeColor,
      ),
      Spacer(),
      // Theme toggle switch widget
      ThemeToggleSwitchWidget(isLightTheme: isLightTheme),
      IconButton(
        icon: Icon(Icons.person,
            color: isLightTheme
                ? AppColors.blackThemeColor
                : AppColors.whiteThemeColor,
            size: 30),
        onPressed: () {
          // do pressed event
        },
      )
    ],
  );
}

Widget buildSearchBar(double screenWidth, BuildContext context) {
  return Container(
    height: 48,
    width: screenWidth * 0.92,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor),
    child: Row(
      children: [
        SizedBox(width: 20),
        Image.asset('assets/Search.png',
            scale: 24, color: AppColors.darkishGrey),
        SizedBox(width: 16),
        Text(
          'Search...',
          style: AppTextStyles.searchBarHintText,
        )
      ],
    ),
  );
}

Widget buildSaleBanner() {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset('assets/sale_cover_image.jpeg',
            fit: BoxFit.cover, height: 185, width: double.infinity),
      ),
      Positioned(
        bottom: 135,
        left: 20,
        child: Text(
          'WULFLEX SUPER SALE',
          style: AppTextStyles.carouselTitleText,
        ),
      ),
      Positioned(
        bottom: 105,
        left: 20,
        child: Text(
          'OFFERS',
          style: AppTextStyles.carouselTitleText,
        ),
      ),
      Positioned(
        bottom: 78,
        left: 20,
        child: Text(
          'UPTO',
          style: AppTextStyles.carouselSubTitleText,
        ),
      ),
      Positioned(
        bottom: 48,
        left: 41,
        child: Text(
          '60%',
          style: AppTextStyles.carouselTitleText,
        ),
      ),
      Positioned(
        bottom: 17,
        left: 20,
        child: Container(
          height: 31,
          width: 95,
          decoration: BoxDecoration(
              color: AppColors.greenThemeColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              'SHOP NOW',
              style: AppTextStyles.carouselShopNowText,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildEquipmentsBanner() {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset('assets/ambitious-studio.jpg',
            fit: BoxFit.cover, height: 185, width: double.infinity),
      ),
      Positioned(
        bottom: 135,
        left: 20,
        child: Text(
          'Unleash Your Strength',
          style: AppTextStyles.carouselTitleText,
        ),
      ),
      Positioned(
        bottom: 105,
        left: 20,
        child: Text(
          'Discover the Best Gym Gear!',
          style: AppTextStyles.carouselTitleText,
        ),
      ),
      Positioned(
        bottom: 78,
        left: 20,
        child: Text(
          'UPTO',
          style: AppTextStyles.carouselSubTitleText,
        ),
      ),
      Positioned(
        bottom: 48,
        left: 41,
        child: Text(
          '20%',
          style: AppTextStyles.carouselTitleText,
        ),
      ),
      Positioned(
        bottom: 17,
        left: 20,
        child: Container(
          height: 31,
          width: 95,
          decoration: BoxDecoration(
              color: AppColors.greenThemeColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              'SHOP NOW',
              style: AppTextStyles.carouselShopNowText,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildcarouselView(
    CarouselSliderController carouselController,
    int currentSlide,
    void Function(int, CarouselPageChangedReason) onPageChanged) {
  return Stack(
    children: [
      CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
              height: 185,
              viewportFraction: 1.0,
              // autoPlay: true,
              onPageChanged: onPageChanged,
              autoPlayInterval: Duration(seconds: 3)),
          items: [buildSaleBanner(), buildEquipmentsBanner()]),
      Positioned(
          left: 170,
          top: 160,
          child: SmoothPageIndicator(
            controller: PageController(initialPage: currentSlide),
            count: 2,
            effect: WormEffect(
                activeDotColor: AppColors.greenThemeColor,
                dotColor: AppColors.whiteThemeColor,
                dotHeight: 7,
                dotWidth: 18),
          ))
    ],
  );
}

Widget buildCategoriesText(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      textAlign: TextAlign.start,
      'CATEGORIES',
      style: AppTextStyles.mainScreenHeadings(context),
    ),
  );
}

Widget buildAllCategories() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        CustomCategoriesContainerWidget(
            iconImagePath: 'assets/dumbell.png',
            categoryTitleText: 'EQUIPMENTS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            iconImagePath: 'assets/suppliments.png',
            categoryTitleText: 'SUPPLIMENTS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            iconImagePath: 'assets/clothing.png',
            categoryTitleText: 'CLOTHING'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            iconImagePath: 'assets/watch.png',
            categoryTitleText: 'ACCESSORIES'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            iconImagePath: 'assets/shoe.png', categoryTitleText: 'APPARELS'),
      ],
    ),
  );
}

Widget buildLastestArrivalsText(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(
      textAlign: TextAlign.start,
      'LATEST ARRIVALS',
      style: AppTextStyles.mainScreenHeadings(context),
    ),
  );
}

Widget buildItemCard(BuildContext context) {
  return GestureDetector(
    onTap: () => NavigationHelper.navigateToWithoutReplacement(
        context, ScreenViewProducts()),
    child: Container(
      padding: EdgeInsets.all(15),
      height: 249,
      width: MediaQuery.sizeOf(context).width * 0.43,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * 0.38,
                  child: Image.asset(
                    'assets/wulflex_logo_nobg.png',
                    fit: BoxFit.fitWidth,
                  ))),
          SizedBox(height: 14),
          Text(
            "Men's dumbell set",
            style: AppTextStyles.itemCardTitleText,
          ),
          SizedBox(height: 6),
          Text(
            "₹ 1099.00",
            style: AppTextStyles.itemCardSubTitleText,
          )
        ],
      ),
    ),
  );
}
