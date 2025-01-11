import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/notification_bloc/notification_bloc_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/settings_screen_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBlocBloc>().add(CheckNotificationPermission());
  }

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
            FadeIn(
              duration: Duration(milliseconds: 100),
              child: SettingsScreenWidgets.buildAppthemeToggler(context)),
            const SizedBox(height: 14),
            FadeIn(
              duration: Duration(milliseconds: 200),
              child: SettingsScreenWidgets.buildNotificationToggeler())
          ],
        ),
      ),
    );
  }
}
