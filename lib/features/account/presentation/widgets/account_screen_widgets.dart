import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/user_model.dart';

Widget buildButtonCards(
    {required IconData icon, required String name, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.only(left: 18, right: 18),
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
              SizedBox(height: 3)
            ],
          ),
          SizedBox(width: 8),
          Text(
            name,
            style: AppTextStyles.buttonCardsText,
          )
        ],
      ),
    ),
  );
}

Widget buildUserProfileImage(String imageUrl) {
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

Widget buildUserGreetingText(
    UserModel user, String Function() getGreeting, BuildContext context) {
  return Center(
    child: Text('${getGreeting()}, ${user.name}',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: AppTextStyles.heyUserWelcomeText(context)),
  );
}

Widget buildAccountHeading(BuildContext context) {
  return Text(
    textAlign: TextAlign.start,
    'ACCOUNT',
    style: AppTextStyles.mainScreenHeadings(context),
  );
}

Widget buildConnectHeading(BuildContext context) {
  return Text(
    textAlign: TextAlign.start,
    'CONNECT',
    style: AppTextStyles.mainScreenHeadings(context),
  );
}

Widget buildAppHeading(BuildContext context) {
  return Text(
    textAlign: TextAlign.start,
    'APP',
    style: AppTextStyles.mainScreenHeadings(context),
  );
}
