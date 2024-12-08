import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/auth/presentation/screens/login_screen.dart';
import 'package:wulflex/features/onboarding/presentation/screens/intro_screen_1.dart';
import 'package:wulflex/features/onboarding/presentation/screens/intro_screen_2.dart';
import 'package:wulflex/features/onboarding/presentation/screens/intro_screen_3.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ScreenMainIntro extends StatefulWidget {
  const ScreenMainIntro({super.key});

  @override
  State<ScreenMainIntro> createState() => _ScreenMainIntroState();
}

class _ScreenMainIntroState extends State<ScreenMainIntro> {
  // Controller to keep track on which page you're on
  final PageController _pageController = PageController();

  // Keep track of if we are on last page
  bool onLastpage = false;

  @override
  void initState() {
    super.initState();
    // Delaying the pre-caching to ensure the context is fully built
    Future.delayed(Duration.zero, () {
      if (mounted) {
        // pre-caching images to make them fully loaded
        precacheImage(AssetImage('assets/intro_image_1.jpg'), context);
        precacheImage(AssetImage('assets/intro_image_2.jpg'), context);
        precacheImage(AssetImage('assets/intro_image_3.png'), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //! I N T R O - P A G E S
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastpage = (index == 2);
              });
            },
            controller: _pageController,
            children: [ScreenIntro1(), ScreenIntro2(), ScreenIntro3()],
          ),

          //! D O T - I N D I C A T O R
          Container(
            alignment: Alignment(0, 0.34),
            child: SmoothPageIndicator(
                effect: WormEffect(
                    activeDotColor: AppColors.greenThemeColor,
                    dotHeight: 8,
                    dotWidth: 19),
                controller: _pageController,
                count: 3),
          ),

          //! N E X T - B U T T O N
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.755,
              left: 0,
              right: 0,
              child: Center(
                  child: GestureDetector(
                      onTap: () {
                        onLastpage
                            ? NavigationHelper.navigateToWithReplacement(context, ScreenLogin(), milliseconds: 600)
                            : _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                      },
                      child: GreenButtonWidget(
                          buttonText: onLastpage ? 'Explore' : 'Next', borderRadius: 15,)))),

          //! S K I P - B U T T O N
          onLastpage
              ? SizedBox.shrink()
              : Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.880,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _pageController.jumpToPage(2),
                    child: Center(
                      child: Text(
                        'Skip',
                        style: AppTextStyles.introScreenSkipButton,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
