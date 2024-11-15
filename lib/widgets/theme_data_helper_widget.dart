import 'package:flutter/material.dart';

bool isLightTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light;
}