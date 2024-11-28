import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/blocs/product_bloc/product_bloc.dart';
import 'package:wulflex/screens/main_screens/account_screens/profile_screen/profile_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/category_screens/all_categories_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/category_screens/categorized_product_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/widgets/theme_toggle_widget.dart';
import 'package:wulflex/screens/main_screens/search_screens/search_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_categories_container_widget.dart';
import 'package:wulflex/widgets/custom_itemCard_widget.dart';
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
          NavigationHelper.navigateToWithoutReplacement(
              context, ScreenProfile());
        },
      )
    ],
  );
}

Widget buildSearchBar(double screenWidth, BuildContext context) {
  return GestureDetector(
    onTap: () => NavigationHelper.navigateToWithoutReplacement(
        context, ScreenSearchScreen()),
    child: Container(
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
            'What are you looking for today?',
            style: AppTextStyles.searchBarHintText,
          )
        ],
      ),
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
    void Function(int, CarouselPageChangedReason) onPageChanged, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
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
    ),
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

Widget buildAllCategories(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'EQUIPMENTS'),
                transitionDuration: 300),
            iconImagePath: 'assets/dumbell.png',
            categoryTitleText: 'EQUIPMENTS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'SUPPLEMENTS'),
                transitionDuration: 300),
            iconImagePath: 'assets/suppliments.png',
            categoryTitleText: 'SUPPLEMENTS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'APPARELS'),
                transitionDuration: 300),
            iconImagePath: 'assets/apparels.png',
            categoryTitleText: 'APPARELS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'ACCESSORIES'),
                transitionDuration: 300),
            iconImagePath: 'assets/watch.png',
            categoryTitleText: 'ACCESSORIES'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenAllCategories(screenTitle: 'ALL CATEGORIES'),
                transitionDuration: 300),
            iconImagePath: 'assets/more_categories_image.png',
            categoryTitleText: '  MORE >>'),
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

// Latest Arrivals Section Implementation
Widget buildLatestArrivalsSection(BuildContext context) {
  return BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      if (state is ProductLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ProductLoaded) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 7.5,
            childAspectRatio: 0.63,
          ),
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            return buildItemCard(context, state.products[index]);
          },
        );
      } else if (state is ProductError) {
        return Center(child: Text('Error: ${state.message}'));
      }
      return SizedBox();
    },
  );
}
