import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

PreferredSizeWidget customAppbarWithBackbutton(
    BuildContext context, String appbarTitle,
    [double spacingWidth = 0.178, bool isBackButtonVisble = true]) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    elevation: 0, // Add this to remove shadow
    scrolledUnderElevation: 0, // Add this to prevent color change on scroll
    surfaceTintColor: Colors.transparent, // Add this to prevent tint
    actions: [
      Expanded(
        child: Row(
          mainAxisAlignment: isBackButtonVisble
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isBackButtonVisble,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLightTheme
                            ? AppColors.lightGreyThemeColor
                            : AppColors.darkishGrey),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 24, color: AppColors.blackThemeColor),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: isBackButtonVisble,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * spacingWidth)),
            Column(
              children: [
                const SizedBox(height: 6.5),
                Text(appbarTitle, style: AppTextStyles.appbarTextBig(context)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
