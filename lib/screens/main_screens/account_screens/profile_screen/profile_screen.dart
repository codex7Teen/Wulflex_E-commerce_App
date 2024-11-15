import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/account_screens/profile_screen/profile_screen_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = isLightTheme(context);

    return Scaffold(
        backgroundColor:
            lightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
        appBar: customAppbarWithBackbutton(context, 'PROFILE'),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 18),
            child: Column(
              children: [
                buildProfilePicture(context),
                buildWelcomeText(context),
                SizedBox(height: 20),
                buildName(),
                SizedBox(height: 15),
                buildAccountInfo(),
                SizedBox(height: 15),
                buildPhoneNumber(),
                SizedBox(height: 15),
                buildDob(),
                SizedBox(height: 20),
                buildEditButton(context),
                SizedBox(height: 20),
                buildDeleteButton(context)
              ],
            ),
          ),
        ));
  }
}
