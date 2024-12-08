import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/features/account/presentation/screens/delete_account_screen.dart';
import 'package:wulflex/features/account/presentation/screens/edit_profile_screen.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_black_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_grey_container_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

Widget buildProfilePicture(BuildContext context, String imageUrl) {
  return Center(
    child: SizedBox(
      height: 180,
      width: 180,
      child: imageUrl.isNotEmpty
          ? Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Lottie.asset('assets/lottie/profile.json'),
              ),
              Positioned(
                  left: 36.6,
                  top: 36,
                  child: SizedBox(
                    height: 180 * 0.6, // 70% of the Lottie's size
                    width: 180 * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          // show image loading indicator
                          return Center(
                              child: Container(
                            height: 180 * 0.6,
                            width: 180 * 0.6,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CircularProgressIndicator(
                                strokeWidth: 6,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null),
                          ));
                        },
                      ),
                    ),
                  ))
            ])
          : ClipRRect(
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

Widget buildPhoneNumber(String phoneNumber) {
  return CustomGreyContainerWidget(
      titleText: 'PHONE NUMBER',
      subtitleText: phoneNumber,
      icon: Icons.phone_android_rounded);
}

Widget buildDob(String dob) {
  return CustomGreyContainerWidget(
      titleText: 'D O B', subtitleText: dob, icon: Icons.cake_rounded);
}

Widget buildEditButton(
    BuildContext context, String name, String phoneNumber, String dob) {
  return GestureDetector(
      onTap: () => NavigationHelper.navigateToWithoutReplacement(
          context,
          ScreenEditProfile(
            screenTitle: 'Edit Profile',
            name: name,
            phoneNumber: phoneNumber,
            dob: dob,
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
    onTap: () => NavigationHelper.navigateToWithoutReplacement(
        context, ScreenDeleteAccount()),
    child:
        CustomBlackButtonWidget(buttonText: "Delete Account", borderRadius: 25),
  );
}
