import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/home_screens/widgets/home_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

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
    // Delaying the pre-caching to ensure the context is fully built
    Future.delayed(Duration.zero, () {
      if (mounted) {
        // pre-caching images to make them fully loaded
        precacheImage(AssetImage('assets/sale_cover_image.jpeg'), context);
        precacheImage(AssetImage('assets/ambitious-studio.jpg'), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteThemeColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
            child: Column(
              children: [
                //! TOP => EXPLORE & PERSON LOGO SECTION
                buildExploreTextAndLogo(),
                SizedBox(height: 15),
                //! SEARCH BAR
                buildSearchBar(screenWidth),
                SizedBox(height: 18),
                //! CAROUSEL VIEW
                buildcarouselView(
                    _carouselController,
                    _currentSlide,
                    (index, reason) => setState(() {
                          _currentSlide = index;
                        })),
                SizedBox(height: 24),
                //! CATEGORIES TEXT
                buildCategoriesText(),
                SizedBox(height: 12),
                //! ALL CATEGORIES
                buildAllCategories(),
                SizedBox(height: 24),
                //! LATEST ARRIVALS TEXT
                buildLastestArrivalsText(),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildItemCard(context),
                    SizedBox(width: 12),
                    buildItemCard(context),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildItemCard(context),
                    SizedBox(width: 12),
                    buildItemCard(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}