import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen.dart';
import 'package:wulflex/screens/intro_screens/intro_screen_1.dart';
import 'package:wulflex/screens/intro_screens/intro_screen_2.dart';
import 'package:wulflex/screens/intro_screens/intro_screen_3.dart';
import 'package:wulflex/widgets/green_button.dart';

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
                            ? Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ScreenLogin()))
                            : _pageController.nextPage(
                                //TODO Adjust this curve animation and duration
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                      },
                      child: GreenButtonWidget(
                          buttonText: onLastpage ? 'Explore' : 'Next')))),

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
                        style: GoogleFonts.robotoCondensed(
                                textStyle: AppTextStyles.skipButtonText)
                            .copyWith(letterSpacing: 1),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
