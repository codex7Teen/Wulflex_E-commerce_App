import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

// Define event and state parts for theme
part 'theme_event.dart';
part 'theme_state.dart';

//! MANAGES THE INITIAL STATE IE, THEME SETS TO LIGHT
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      // Initialize the BLoC with a default light theme
      : super(ThemeState(
            themeData: ThemeData(
                primaryColor: AppColors.greenThemeColor,
                colorScheme: ColorScheme(
                    primary: AppColors.greenThemeColor,
                    primaryContainer: AppColors.greenThemeColor,
                    secondary: AppColors.blueThemeColor,
                    secondaryContainer: AppColors.blueThemeColor,
                    surface: const Color.fromRGBO(255, 255, 255, 1),
                    error: AppColors.redThemeColor,
                    onPrimary: AppColors.whiteThemeColor,
                    onSecondary: AppColors.whiteThemeColor,
                    onSurface: AppColors.blackThemeColor,
                    onError: AppColors.whiteThemeColor,
                    brightness: Brightness.light),
                checkboxTheme: CheckboxThemeData(
                    side: WidgetStateBorderSide.resolveWith((states) {
                  if (!states.contains(WidgetState.selected)) {
                    return BorderSide(color: AppColors.greenThemeColor);
                  }
                  return BorderSide(color: AppColors.greenThemeColor);
                }))))) {
    //! EVENT WHICH TOGGLES B/W LIGHT AND DARK THEME
    on<ToggleThemeButtonPressed>((event, emit) {
      // Check if the current theme is light
      final isCurrentlyLight = state.themeData.brightness == Brightness.light;

      // Emit a new theme state with the toggled brightness
      emit(ThemeState(
          themeData: ThemeData(
              primaryColor: AppColors.greenThemeColor,
              colorScheme: ColorScheme(
                primary: AppColors.greenThemeColor,
                primaryContainer: AppColors.greenThemeColor,
                secondary: AppColors.blueThemeColor,
                secondaryContainer: AppColors.blueThemeColor,
                surface: AppColors.whiteThemeColor,
                error: AppColors.redThemeColor,
                onPrimary: AppColors.whiteThemeColor,
                onSecondary: AppColors.whiteThemeColor,
                onSurface: AppColors.blackThemeColor,
                onError: AppColors.whiteThemeColor,
                brightness: isCurrentlyLight
                    ? Brightness.dark
                    : Brightness.light, // Toggle brightness
              ),
              
              checkboxTheme: CheckboxThemeData(
                  side: WidgetStateBorderSide.resolveWith((states) {
                if (!states.contains(WidgetState.selected)) {
                  return BorderSide(color: AppColors.greenThemeColor);
                }
                return BorderSide(color: AppColors.greenThemeColor);
              })))));
      log('THEME CHANGE SUCCESS');
    });
  }
}
