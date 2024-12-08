import 'package:flutter/material.dart';
import 'package:wulflex/features/account/presentation/widgets/settings_screen_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'SETTINGS', 0.155),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 18, right: 18, bottom: 18),
        child: Column(
          children: [
            SettingsScreenWidgets.buildAppthemeToggler(context),
          ],
        ),
      ),
    );
  }
}
