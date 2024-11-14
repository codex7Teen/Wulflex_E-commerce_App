import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/account_screens/profile_screen/edit_profile_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_grey_container_widget.dart';
import 'package:wulflex/widgets/custom_red_button_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
        backgroundColor: isLightTheme
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        appBar: customAppbarWithBackbutton(context, 'PROFILE'),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 18),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/profile.png',
                        fit: BoxFit.fitWidth,
                        color: isLightTheme
                            ? AppColors.blackThemeColor
                            : AppColors.whiteThemeColor,
                      ),
                    ),
                  ),
                ),
                Text('Hey, Dennis',
                    style: AppTextStyles.heyUserWelcomeText(context)),
                SizedBox(height: 20),
                CustomGreyContainerWidget(
                    titleText: 'NAME',
                    subtitleText: 'Dennis Johnson',
                    icon: Icons.person),
                SizedBox(height: 15),
                CustomGreyContainerWidget(
                    titleText: 'ACCOUNT INFORMATION',
                    subtitleText: 'djconnect189@gmail.com',
                    icon: Icons.account_circle_rounded),
                    SizedBox(height: 15),
                CustomGreyContainerWidget(
                    titleText: 'PHONE NUMBER',
                    subtitleText: '',
                    icon: Icons.phone_android_rounded),
                    SizedBox(height: 15),
                CustomGreyContainerWidget(
                    titleText: 'D O B',
                    subtitleText: '',
                    icon: Icons.cake_rounded),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => NavigationHelper.navigateToWithoutReplacement(context, ScreenEditProfile(screenTitle: 'Edit Profile')),
                      child: GreenButtonWidget(buttonText: 'Edit Profile', borderRadius: 25, width: 1,)),
                    SizedBox(height: 20),
                    CustomRedButtonWidget(buttonText: "Delete Account", borderRadius: 25)
              ],
            ),
          ),
        ));
  }
}
