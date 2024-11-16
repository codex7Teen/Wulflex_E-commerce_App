import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

// Define event and state parts
part 'theme_event.dart';
part 'theme_state.dart';

// Bloc to manage the theme state
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // Initialize with the default light theme
  ThemeBloc() : super(_initialThemeState()) {
    // Listen to ToggleThemeButtonPressed event
    on<ToggleThemeButtonPressed>(_toggleTheme);

    // Listen to LoadSavedTheme event
    on<LoadSavedTheme>(_loadSavedTheme);
  }

  // Default light theme state
  static ThemeState _initialThemeState() {
    return ThemeState(
        themeData: ThemeData(
            brightness: Brightness.light,
            primaryColor: AppColors.greenThemeColor,
            colorScheme: ColorScheme.light(
              primary: AppColors.greenThemeColor,
              secondary: AppColors.blueThemeColor,
              primaryContainer: AppColors.greenThemeColor,
              secondaryContainer: AppColors.blueThemeColor,
              surface: const Color.fromRGBO(255, 255, 255, 1),
              error: AppColors.redThemeColor,
              onPrimary: AppColors.whiteThemeColor,
              onSecondary: AppColors.whiteThemeColor,
              onSurface: AppColors.blackThemeColor,
              onError: AppColors.whiteThemeColor,
            ),
            checkboxTheme: CheckboxThemeData(
                side: WidgetStateBorderSide.resolveWith((states) {
              if (!states.contains(WidgetState.selected)) {
                return BorderSide(color: AppColors.greenThemeColor);
              }
              return BorderSide(color: AppColors.greenThemeColor);
            }))));
  }

  // Function to handle theme toggle
  Future<void> _toggleTheme(
      ToggleThemeButtonPressed event, Emitter<ThemeState> emit) async {
    // Check if the current theme is light
    final isCurrentlyLight = state.themeData.brightness == Brightness.light;

    // Save the toggled theme to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightTheme', !isCurrentlyLight);

    // Emit new theme state with toggled brightness
    emit(ThemeState(
      themeData: ThemeData(
          brightness: isCurrentlyLight ? Brightness.dark : Brightness.light,
          primaryColor: AppColors.greenThemeColor,
          colorScheme: ColorScheme(
            primaryContainer: AppColors.greenThemeColor,
            secondary: AppColors.blueThemeColor,
            secondaryContainer: AppColors.blueThemeColor,
            surface: AppColors.whiteThemeColor,
            error: AppColors.redThemeColor,
            onPrimary: AppColors.whiteThemeColor,
            onSecondary: AppColors.whiteThemeColor,
            onSurface: AppColors.blackThemeColor,
            onError: AppColors.whiteThemeColor,
            primary: AppColors.greenThemeColor,
            brightness: isCurrentlyLight ? Brightness.dark : Brightness.light,
          ),
          checkboxTheme: CheckboxThemeData(
              side: WidgetStateBorderSide.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return BorderSide(color: AppColors.greenThemeColor);
            }
            return BorderSide(color: AppColors.greenThemeColor);
          }))),
    ));

    log('Theme toggled successfully');
  }

  // Function to load the saved theme on app start
  Future<void> _loadSavedTheme(
      LoadSavedTheme event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    // Get the saved theme or default to light
    final isLightTheme = prefs.getBool('isLightTheme') ?? true;

    // Emit the saved theme state
    emit(ThemeState(
      themeData: ThemeData(
          brightness: isLightTheme ? Brightness.light : Brightness.dark,
          primaryColor: AppColors.greenThemeColor,
          colorScheme: ColorScheme(
            primaryContainer: AppColors.greenThemeColor,
            secondary: AppColors.blueThemeColor,
            secondaryContainer: AppColors.blueThemeColor,
            surface: AppColors.whiteThemeColor,
            error: AppColors.redThemeColor,
            onPrimary: AppColors.whiteThemeColor,
            onSecondary: AppColors.whiteThemeColor,
            onSurface: AppColors.blackThemeColor,
            onError: AppColors.whiteThemeColor,
            primary: AppColors.greenThemeColor,
            brightness: isLightTheme ? Brightness.light : Brightness.dark,
          ),
          checkboxTheme: CheckboxThemeData(
              side: WidgetStateBorderSide.resolveWith((states) {
            if (!states.contains(WidgetState.selected)) {
              return BorderSide(color: AppColors.greenThemeColor);
            }
            return BorderSide(color: AppColors.greenThemeColor);
          }))),
    ));

    log('Saved theme loaded successfully');
  }
}
