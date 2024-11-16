import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:wulflex/blocs/theme_bloc/theme_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

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
        width: 55,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: isLightTheme ? AppColors.lightGreyThemeColor : Colors.white,
        ),
        child: Stack(
          children: [
            AnimatedPositioned( // Replace Positioned with AnimatedPositioned
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut, // Add smooth easing curve
              left: isLightTheme ? 5.0 : 30.0,
              top: 4.0, // Center vertically
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // Add fade transition for icon change
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: isLightTheme
                    ? Icon(
                        Icons.brightness_medium_outlined,
                        key: const ValueKey('sun'),
                        color: AppColors.blackThemeColor,
                        size: 20,
                      )
                    : Icon(
                        Icons.dark_mode_sharp,
                        key: const ValueKey('moon'),
                        color: AppColors.blackThemeColor,
                        size: 20,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
