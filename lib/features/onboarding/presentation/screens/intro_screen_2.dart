import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

class ScreenIntro2 extends StatefulWidget {
  const ScreenIntro2({super.key});

  @override
  State<ScreenIntro2> createState() => _ScreenIntro2State();
}

class _ScreenIntro2State extends State<ScreenIntro2> {
  // bool to shoow animation for image
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Black placeholder background while image loads
        Container(color: Colors.black),
        
        // Background image with fade
        AnimatedOpacity(
          opacity: _imageLoaded ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: SizedBox.expand(
            child: Image.asset(
              'assets/intro_image_2.jpg',
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame != null) {
                  // Image has loaded
                  Future.delayed(Duration(milliseconds: 100), () {
                    if (mounted) {
                      setState(() {
                        _imageLoaded = true;
                      });
                    }
                  });
                }
                return child;
              },
            ),
          ),
        ),

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
                  'Gear Up\n for Peak Performance',
                  style: AppTextStyles.introScreenHeading),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                //! S U B - H E A D I N G
                child: Text(
                    textAlign: TextAlign.center,
                    'From essential equipment to pro-level accessories, we bring everything to support your goals. Unleash your potential with the right gear.',
                    style: AppTextStyles.introScreenSubheading),
              ),

              SizedBox(height: 120)
            ],
          ),
        )
      ],
    );
  }
}