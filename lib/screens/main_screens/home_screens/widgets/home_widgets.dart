import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/blocs/product_bloc/product_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/screens/main_screens/account_screens/profile_screen/profile_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/all_categories_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/categorized_product_screen.dart';
import 'package:wulflex/screens/main_screens/home_screens/widgets/theme_toggle_widget.dart';
import 'package:wulflex/screens/main_screens/search_screens/search_screen.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/view_product_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_categories_container_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

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

Widget buildAllCategories(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'EQUIPMENTS')),
            iconImagePath: 'assets/dumbell.png',
            categoryTitleText: 'EQUIPMENTS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'SUPPLEMENTS')),
            iconImagePath: 'assets/suppliments.png',
            categoryTitleText: 'SUPPLEMENTS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'APPARELS')),
            iconImagePath: 'assets/apparels.png',
            categoryTitleText: 'APPARELS'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenCategorizedProduct(categoryName: 'ACCESSORIES')),
            iconImagePath: 'assets/watch.png',
            categoryTitleText: 'ACCESSORIES'),
        SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, ScreenAllCategories(screenTitle: 'ALL CATEGORIES')),
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

// buildItemCard widget
Widget buildItemCard(BuildContext context, ProductModel product) {
  // Calculating discount percentage
  final discountPercentage =
      (((product.retailPrice - product.offerPrice) / product.retailPrice) * 100)
          .round();

  return GestureDetector(
    onTap: () => NavigationHelper.navigateToWithoutReplacement(
        context, ScreenViewProducts(productModel: product)),
    child: Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
          bottom: 10), // Added margin to prevent potential overflow
      width: MediaQuery.sizeOf(context).width * 0.43,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Added to prevent overflow
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * 0.38,
                  child: Image.network(
                    product.imageUrls[0],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset('assets/wulflex_logo_nobg.png'),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                          child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null));
                    },
                  )),
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brandName,
                  style: AppTextStyles.itemCardBrandText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.name,
                  style: AppTextStyles.itemCardNameText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "₹${product.retailPrice.round()}",
                      style: AppTextStyles.itemCardSecondSubTitleText,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "₹${product.offerPrice.round()}",
                      style: AppTextStyles.itemCardSubTitleText,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? AppColors.whiteThemeColor
                        : const Color.fromARGB(
                            255, 247, 247, 247), // Light red background
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Save upto $discountPercentage%",
                      style: AppTextStyles.itemCardThirdSubTitleText),
                ),
              ],
            ),
          ),
        ],
      ),
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
            mainAxisSpacing: 18,
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
