import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ScreenSplash1 extends StatefulWidget {
  final User? authenticatedUser;
  final Widget screen;
  const ScreenSplash1(
      {super.key, this.authenticatedUser, required this.screen});

  @override
  State<ScreenSplash1> createState() => _ScreenSplash1State();
}

class _ScreenSplash1State extends State<ScreenSplash1> {
  bool _animateTextLogo = false;
  bool _animateLogo = false;

  @override
  void initState() {
    super.initState();

    // Delay for 1.5 second before triggering the animations
    Future.delayed(Duration(milliseconds: 1500), () {
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

    // Trigger the event to load the saved theme
    context.read<ThemeBloc>().add(LoadSavedTheme());

//TODO CHANGE MILLISECS TO 3000
    // Navigate to intro-screen or Main screen based on argument
    Future.delayed(Duration(milliseconds: 3), () {
      if (mounted) {
        NavigationHelper.navigateToWithReplacement(context, widget.screen,
            milliseconds: 800);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteThemeColor,
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
                          child: ColoredBox(color: AppColors.whiteThemeColor)),
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
