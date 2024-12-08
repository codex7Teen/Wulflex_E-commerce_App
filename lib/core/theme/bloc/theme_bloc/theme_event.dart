part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

//! Toggled button pressed event
class ToggleThemeButtonPressed extends ThemeEvent {}

//! Event to load saved theme
class LoadSavedTheme extends ThemeEvent {}
