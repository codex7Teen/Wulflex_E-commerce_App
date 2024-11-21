import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/screens/main_screens/account_screens/delete%20_account_screen/delete_account_screen.dart';
import 'package:wulflex/screens/main_screens/account_screens/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_black_button_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_grey_container_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

Widget buildProfilePicture(BuildContext context) {
  return Center(
    child: SizedBox(
      height: 180,
      width: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Lottie.asset('assets/lottie/profile.json'),
      ),
    ),
  );
}

Widget buildWelcomeText(BuildContext context, String name) {
  return Text('Hey, $name', style: AppTextStyles.heyUserWelcomeText(context));
}

Widget buildName(String name) {
  return CustomGreyContainerWidget(
      titleText: 'NAME', subtitleText: name, icon: Icons.person);
}

Widget buildAccountInfo(String email) {
  return CustomGreyContainerWidget(
      titleText: 'ACCOUNT INFORMATION',
      subtitleText: email,
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
  return GestureDetector(
    onTap: () => NavigationHelper.navigateToWithoutReplacement(context, ScreenDeleteAccount()),
    child: CustomBlackButtonWidget(
        buttonText: "Delete Account", borderRadius: 25),
  );
}