import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class AccountScreenWidgets {
  static Widget buildButtonCards(
      {required IconData icon, required String name, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 18, right: 18),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.lightGreyThemeColor,
            borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: AppColors.blackThemeColor,
                ),
                const SizedBox(height: 3)
              ],
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: AppTextStyles.buttonCardsText,
            )
          ],
        ),
      ),
    );
  }

  static Widget buildUserProfileImage(String imageUrl) {
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
                    child: Hero(
                      tag: 'user_image',
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
                                  color: AppColors.blackThemeColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircularProgressIndicator(
                                    strokeWidth: 6,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null),
                              ));
                            },
                          ),
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

  static Widget buildUserGreetingText(
      UserModel user, String Function() getGreeting, BuildContext context) {
    return Center(
      child: Text('${getGreeting()}, ${user.name}',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: AppTextStyles.heyUserWelcomeText(context)),
    );
  }

  static Widget buildAccountHeading(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      'ACCOUNT',
      style: AppTextStyles.mainScreenHeadings(context),
    );
  }

  static Widget buildConnectHeading(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      'CONNECT',
      style: AppTextStyles.mainScreenHeadings(context),
    );
  }

  static Widget buildAppHeading(BuildContext context) {
    return Text(
      textAlign: TextAlign.start,
      'APP',
      style: AppTextStyles.mainScreenHeadings(context),
    );
  }

  // Helper method to determine greeting
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  static Future<void> launchInstagram() async {
    final Uri url = Uri.parse(
        'https://www.instagram.com/denniz_jhnsn?igsh=MWFqdmc5b2FpcHA5');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static Widget buildAppLogo(BuildContext context) {
    return Center(
      child: Image.asset("assets/wulflex_logo_nobg.png",
          width: 27,
          color: isLightTheme(context)
              ? AppColors.blackThemeColor
              : AppColors.whiteThemeColor),
    );
  }

  static Widget buildAppVersion(BuildContext context) {
    return Center(
      child: Text('Version: 1.0.1',
          style: AppTextStyles.ratingScreenTextFieldhintStyle(context)),
    );
  }
}
