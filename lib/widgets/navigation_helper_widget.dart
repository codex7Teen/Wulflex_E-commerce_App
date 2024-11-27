import 'package:flutter/material.dart';

class NavigationHelper {
  // Method for navigating with a fade transition
  static void navigateToWithReplacement(BuildContext context, Widget page, {int milliseconds = 400}) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration:  Duration(milliseconds: milliseconds),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ));
  }

  // You can add more methods for different navigation needs
  static void navigateToWithoutReplacement(BuildContext context, Widget page, {int transitionDuration = 400}) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: transitionDuration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ));
  }
}
