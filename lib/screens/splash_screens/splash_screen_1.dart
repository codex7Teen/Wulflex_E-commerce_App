import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/screens/intro_screens/main_intro_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplash2State();
}

class _ScreenSplash2State extends State<ScreenSplash> {
  bool _animateTextLogo = false;
  bool _animateLogo = false;

  @override
  void initState() {
    super.initState();

    // Delay for 1 second before triggering the animations
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _animateLogo = true;
        });

        // After triggering the logo animation, delay for the text logo animation
        Future.delayed(Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _animateTextLogo = true;
            });
          }
        });
      }
    });

    // Navigate to intro screen after some seconds
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ScreenMainIntro(),
              transitionDuration: Duration(milliseconds: 600),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldColor,
      body: Center(
        child: ClipRect(
          child: SizedBox(
            width: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Wulflex text that moves from right to center (background) with opacity animation
                AnimatedPositioned(
                  duration: Duration(milliseconds: 800),
                  left: _animateTextLogo ? 80 : 0,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 800),
                    opacity: _animateTextLogo ? 1.0 : 0.0,
                    child: Image.asset(
                      'assets/wulflex_text_nobg.png',
                      width: 135,
                    ),
                  ),
                ),
                // Logo that stays centered initially, then moves slightly left (foreground)
                AnimatedPositioned(
                  duration: Duration(milliseconds: 800),
                  left: _animateLogo ? -77 : 0,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 75,
                          height: 75,
                          child:
                              ColoredBox(color: AppColors.lightScaffoldColor)),
                      Image.asset(
                        'assets/wulflex_logo_white_bg.jpg',
                        width: 75,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
