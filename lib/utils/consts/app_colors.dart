import 'package:flutter/material.dart';

class AppColors {
  //! CONSTANT APP COLORS
  static const Color whiteThemeColor = Colors.white;
  static const Color blackThemeColor = Colors.black;
  static const Color redThemeColor = Colors.red;
  static const Color greenThemeColor = Color.fromARGB(255, 158, 221, 0);
  static const Color greyThemeColor = Colors.grey;
  static const Color lightGreyThemeColor = Color.fromARGB(255, 232, 232, 232);
  static const Color darkishGrey = Color.fromARGB(255, 100, 100, 100);
  static const Color blueThemeColor = Color.fromARGB(255, 0, 51, 255);

  //! THEME COLORS
  static Color scaffoldColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? whiteThemeColor
          : blackThemeColor;
}
