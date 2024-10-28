import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';

class ScreenIntro3 extends StatelessWidget {
  const ScreenIntro3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        SizedBox.expand(
            child: Image.asset(
          'assets/intro_image_3.jpg',
          fit: BoxFit.cover,
        )),

        // Applying blur
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        )),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //! M A I N - H E A D I N G
              Text(
                  textAlign: TextAlign.center,
                  'Track, Order, Achieve',
                  style: GoogleFonts.bebasNeue(
                      textStyle: AppTextStyles.headingLarge).copyWith(color: AppColors.lightScaffoldColor)),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                //! S U B - H E A D I N G
                child: Text(
                    textAlign: TextAlign.center,
                    'Easily explore, order, and track your fitness essentials. Start achieving with confidence and get closer to your goals every day.',
                    style: GoogleFonts.robotoCondensed(
                        textStyle: AppTextStyles.headingSmall
                            .copyWith(color: Colors.grey, letterSpacing: 0.5))),
              ),

              SizedBox(height: 120)
            ],
          ),
        )
      ],
    );
  }
}