import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:wulflex/core/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';

class ThemeToggleSwitchWidget extends StatelessWidget {
  final bool isLightTheme;

  const ThemeToggleSwitchWidget({super.key, required this.isLightTheme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        BlocProvider.of<ThemeBloc>(context).add(ToggleThemeButtonPressed());
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60, // Adjusted width for proper design
        height: 30, // Adjusted height for proportions
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: isLightTheme
              ? AppColors.lightGreyThemeColor // Background for light mode
              : AppColors.greenThemeColor, // Background for dark mode
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isLightTheme ? 2.0 : 32.0, // Adjusted positions for thumb
              top: 2.0,
              child: Container(
                width: 26, // Thumb size
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLightTheme
                      ? AppColors.blackThemeColor // Thumb color for light mode
                      : AppColors
                          .lightGreyThemeColor, // Thumb color for dark mode
                ),
                child: Icon(
                  isLightTheme
                      ? Icons
                          .brightness_medium_outlined // Sun icon for light mode
                      : Icons.dark_mode_sharp, // Moon icon for dark mode
                  color: isLightTheme
                      ? AppColors.lightGreyThemeColor
                      : AppColors.blackThemeColor,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
