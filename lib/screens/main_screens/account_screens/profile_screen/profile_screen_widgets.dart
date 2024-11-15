import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/account_screens/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_black_button_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_grey_container_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

Widget buildProfilePicture(BuildContext context) {
  final lightTheme = isLightTheme(context);
  return Center(
    child: SizedBox(
      height: 180,
      width: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          'assets/profile.png',
          fit: BoxFit.fitWidth,
          color: lightTheme
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor,
        ),
      ),
    ),
  );
}

Widget buildWelcomeText(BuildContext context) {
  return Text('Hey, Dennis', style: AppTextStyles.heyUserWelcomeText(context));
}

Widget buildName() {
  return CustomGreyContainerWidget(
      titleText: 'NAME', subtitleText: 'Dennis Johnson', icon: Icons.person);
}

Widget buildAccountInfo() {
  return CustomGreyContainerWidget(
      titleText: 'ACCOUNT INFORMATION',
      subtitleText: 'djconnect189@gmail.com',
      icon: Icons.account_circle_rounded);
}

Widget buildPhoneNumber() {
  return CustomGreyContainerWidget(
      titleText: 'PHONE NUMBER',
      subtitleText: '',
      icon: Icons.phone_android_rounded);
}

Widget buildDob() {
  return CustomGreyContainerWidget(
      titleText: 'D O B', subtitleText: '', icon: Icons.cake_rounded);
}

Widget buildEditButton(BuildContext context) {
  return GestureDetector(
      onTap: () => NavigationHelper.navigateToWithoutReplacement(
          context,
          ScreenEditProfile(
            screenTitle: 'Edit Profile',
            name: 'Dennis Johnson',
          )),
      child: GreenButtonWidget(
        buttonText: 'Edit Profile',
        borderRadius: 25,
        width: 1,
        addIcon: true,
        icon: Icons.edit,
      ));
}

Widget buildDeleteButton(BuildContext context) {
  return CustomBlackButtonWidget(
      buttonText: "Delete Account", borderRadius: 25);
}
