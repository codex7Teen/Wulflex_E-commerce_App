import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';
import 'package:wulflex/features/account/presentation/screens/profile_screen.dart';
import 'package:wulflex/features/home/presentation/screens/all_categories_screen.dart';
import 'package:wulflex/features/home/presentation/screens/categorized_product_screen.dart';
import 'package:wulflex/features/home/presentation/screens/sale_screen.dart';
import 'package:wulflex/shared/widgets/theme_toggle_widget.dart';
import 'package:wulflex/features/search/presentation/screens/search_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_categories_container_widget.dart';
import 'package:wulflex/shared/widgets/custom_itemCard_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

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
      const SizedBox(width: 14),
      Image.asset(
        'assets/wulflex_logo_nobg.png',
        width: 30,
        color: isLightTheme
            ? AppColors.blackThemeColor
            : AppColors.whiteThemeColor,
      ),
      const Spacer(),
      // Theme toggle switch widget
      ThemeToggleSwitchWidget(isLightTheme: isLightTheme),
      BlocBuilder<UserProfileBloc, UserProfileState>(
        buildWhen: (previous, current) {
          return current is UserProfileLoaded;
        },
        builder: (context, state) {
          if (state is UserProfileLoaded) {
            final user = state.user;
            if (user.userImage != null) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 4),
                child: GestureDetector(
                  onTap: () => NavigationHelper.navigateToWithoutReplacement(
                      context, const ScreenProfile()),
                  child: SizedBox(
                      height: 28,
                      width: 28,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Hero(
                            tag: 'user_image',
                            child: CachedNetworkImage(
                              imageUrl: user.userImage!,
                              fit: BoxFit.cover,
                            ),
                          ))),
                ),
              );
            }
            return IconButton(
                icon: Icon(Icons.person,
                    color: isLightTheme
                        ? AppColors.blackThemeColor
                        : AppColors.whiteThemeColor,
                    size: 30),
                onPressed: () => NavigationHelper.navigateToWithoutReplacement(
                    context, const ScreenProfile()));
          }
          return IconButton(
            icon: Icon(Icons.person,
                color: isLightTheme
                    ? AppColors.blackThemeColor
                    : AppColors.whiteThemeColor,
                size: 30),
            onPressed: () {
              NavigationHelper.navigateToWithoutReplacement(
                  context, const ScreenProfile());
            },
          );
        },
      )
    ],
  );
}

Widget buildSearchBar(double screenWidth, BuildContext context) {
  return GestureDetector(
    onTap: () => NavigationHelper.navigateToWithoutReplacement(
        context, const ScreenSearchScreen()),
    child: Container(
      height: 48,
      width: screenWidth * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Image.asset(
            'assets/Search.png',
            scale: 24,
            color: AppColors.darkishGrey,
          ),
          const SizedBox(width: 16),
          DefaultTextStyle(
            style: AppTextStyles.searchBarHintText,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'What are you looking for today?',
                  speed: const Duration(milliseconds: 80),
                  cursor: '',
                ),
              ],
              isRepeatingAnimation: false,
              displayFullTextOnTap: false,
            ),
          ),
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
        child: Image.asset('assets/sales_banner_2.jpg',
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
            onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
                const ScreenCategorizedProduct(categoryName: 'EQUIPMENTS'),
                transitionDuration: 300),
            iconImagePath: 'assets/dumbell.png',
            categoryTitleText: 'EQUIPMENTS'),
        const SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
                const ScreenCategorizedProduct(categoryName: 'SUPPLEMENTS'),
                transitionDuration: 300),
            iconImagePath: 'assets/suppliments.png',
            categoryTitleText: 'SUPPLEMENTS'),
        const SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
                const ScreenCategorizedProduct(categoryName: 'APPARELS'),
                transitionDuration: 300),
            iconImagePath: 'assets/apparels.png',
            categoryTitleText: 'APPARELS'),
        const SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
                const ScreenCategorizedProduct(categoryName: 'ACCESSORIES'),
                transitionDuration: 300),
            iconImagePath: 'assets/watch.png',
            categoryTitleText: 'ACCESSORIES'),
        const SizedBox(width: 14),
        CustomCategoriesContainerWidget(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
                const ScreenAllCategories(screenTitle: 'ALL CATEGORIES'),
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

Widget buildLatestArrivalsSection(BuildContext context) {
  return BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      if (state is ProductLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ProductLoaded) {
        final products = state.products;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 7.5,
            childAspectRatio: 0.545,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return buildItemCard(context, products[index]);
          },
        );
      } else if (state is ProductError) {
        return Center(child: Text('Error: ${state.message}'));
      }
      return const SizedBox();
    },
  );
}

//! CAROUSEL
class EnhancedCarousel extends StatefulWidget {
  const EnhancedCarousel({super.key});

  @override
  State<EnhancedCarousel> createState() => _EnhancedCarouselState();
}

class _EnhancedCarouselState extends State<EnhancedCarousel> {
  late PageController _pageController;
  double _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChanged);
    _setupAutoScroll();
  }

  void _onPageChanged() {
    if (mounted) {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    }
  }

  void _setupAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % 2;
        _pageController.animateToPage(
          nextPage.toInt(),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  Widget _buildCarouselItem(Widget banner, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        double opacity = 1.0;

        if (_pageController.position.haveDimensions) {
          value = _currentPage - index;
          // Scale animation
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
          // Fade animation - increased intensity by adjusting multiplier and minimum opacity
          opacity = (1 - (value.abs() * 0.9)).clamp(0.15, 1.0);
        }

        return Transform.scale(
          scale: value,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: index == _currentPage.round() ? 1.0 : opacity,
            child: banner,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationHelper.navigateToWithoutReplacement(
          context, const ScreenSaleScreen(screenName: 'Sale')),
      child: Stack(
        children: [
          SizedBox(
            height: 185,
            child: PageView(
              controller: _pageController,
              children: [
                _buildCarouselItem(buildSaleBanner(), 0),
                _buildCarouselItem(buildEquipmentsBanner(), 1),
              ],
            ),
          ),
          Positioned(
            left: 170,
            top: 160,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const WormEffect(
                activeDotColor: AppColors.greenThemeColor,
                dotColor: AppColors.whiteThemeColor,
                dotHeight: 7,
                dotWidth: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
