import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';
import 'package:wulflex/features/home/presentation/screens/sale_screen.dart';
import 'package:wulflex/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentSlide = 0;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartEvent());
    context.read<FavoriteBloc>().add(LoadFavoritesEvent());
    // Delaying the pre-caching to ensure the context is fully built
    Future.delayed(Duration.zero, () {
      if (mounted) {
        // pre-caching images to make them fully loaded
        precacheImage(AssetImage('assets/sale_cover_image.jpeg'), context);
        precacheImage(AssetImage('assets/sales_banner_2.jpg'), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadProducts());
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
            child: Column(
              children: [
                //! TOP => EXPLORE & PERSON LOGO SECTION
                FadeInDown(
                  child: buildExploreTextAndLogo(context),
                ),
                SizedBox(height: 15),
                //! SEARCH BAR
                FadeInDown(
                  delay: Duration(milliseconds: 150),
                  child: buildSearchBar(screenWidth, context),
                ),
                SizedBox(height: 18),
                //! CAROUSEL VIEW
                FadeInDown(
                  delay: Duration(milliseconds: 250),
                  child: buildcarouselView(
                      _carouselController,
                      _currentSlide,
                      (index, reason) => setState(() {
                            _currentSlide = index;
                          }),
                      () => NavigationHelper.navigateToWithoutReplacement(
                          context, ScreenSaleScreen(screenName: 'Sale'))),
                ),
                SizedBox(height: 24),
                //! CATEGORIES TEXT
                FadeInDown(
                  delay: Duration(milliseconds: 550),
                  child: buildCategoriesText(context),
                ),
                SizedBox(height: 10),
                //! ALL CATEGORIES
                FadeInDown(
                  delay: Duration(milliseconds: 750),
                  child: buildAllCategories(context),
                ),
                SizedBox(height: 24),
                //! LATEST ARRIVALS TEXT
                FadeInDown(
                  delay: Duration(milliseconds: 950),
                  child: buildLastestArrivalsText(context),
                ),
                SizedBox(height: 14),
                FadeInUp(
                  delay: Duration(milliseconds: 1150),
                  child: buildLatestArrivalsSection(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
