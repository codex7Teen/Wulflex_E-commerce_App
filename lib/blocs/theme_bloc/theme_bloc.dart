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
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.grey,
                  brightness:
                      Brightness.light, // Default brightness set to light
                ).copyWith(
                    secondary: AppColors.blueThemeColor), // Secondary color
                brightness: Brightness.light))) {
    //! EVENT WHICH TOGGLES B/W LIGHT AND DARK THEME
    on<ToggleThemeButtonPressed>((event, emit) {
      // Check if the current theme is light
      final isCurrentlyLight = state.themeData.brightness == Brightness.light;

      // Emit a new theme state with the toggled brightness
      emit(ThemeState(
          themeData: ThemeData(
        primaryColor: AppColors.greenThemeColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: isCurrentlyLight
              ? Brightness.dark
              : Brightness.light, // Toggle to dark if light, or vice versa
        ).copyWith(secondary: AppColors.blueThemeColor),
        brightness: isCurrentlyLight
            ? Brightness.dark
            : Brightness.light, // Apply the toggled brightness
      )));
      log('THEME CHANGE SUCCESS');
    });
  }
}
