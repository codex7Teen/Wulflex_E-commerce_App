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
          alignment: Alignment.center,
          children: [
            Positioned(
              left: isLightTheme ? 5.0 : 30.0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isLightTheme
                    ? Icon(
                        Icons.brightness_medium_outlined,
                        key: ValueKey('sun'),
                        color: AppColors.blackThemeColor,
                        size: 20,
                      )
                    : Icon(
                        Icons.dark_mode_sharp,
                        key: ValueKey('moon'),
                        color: Colors.deepPurpleAccent[200],
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
