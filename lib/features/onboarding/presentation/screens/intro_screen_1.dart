import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wulflex/core/config/text_styles.dart';

class ScreenIntro1 extends StatefulWidget {
  const ScreenIntro1({super.key});

  @override
  State<ScreenIntro1> createState() => _ScreenIntro1State();
}

class _ScreenIntro1State extends State<ScreenIntro1> {
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
          duration: const Duration(milliseconds: 500),
          child: SizedBox.expand(
            child: Image.asset(
              'assets/intro_image_1.jpg',
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame != null) {
                  // Image has loaded
                  Future.delayed(const Duration(milliseconds: 100), () {
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
            color: Colors.black.withValues(alpha: 0.1),
          ),
        )),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //! M A I N - H E A D I N G
              Text(
                  textAlign: TextAlign.center,
                  'UNLEASH\n YOUR FITNESS POTENTIAL',
                  style: AppTextStyles.introScreenHeading),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                //! S U B - H E A D I N G
                child: Text(
                    textAlign: TextAlign.center,
                    'Discover top-quality gym equipment and gear tailored for fitness enthusiasts. Begin your journey to a stronger you with just a few taps!',
                    style: AppTextStyles.introScreenSubheading),
              ),

              const SizedBox(height: 120)
            ],
          ),
        )
      ],
    );
  }
}
