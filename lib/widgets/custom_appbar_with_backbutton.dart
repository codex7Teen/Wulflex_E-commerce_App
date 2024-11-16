import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

PreferredSizeWidget customAppbarWithBackbutton(BuildContext context, String appbarTitle, [double spacingWidth = 0.178]) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    actions: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLightTheme ? AppColors.lightGreyThemeColor : AppColors.whiteThemeColor),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.blackThemeColor),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width * spacingWidth),
            Text(appbarTitle, style: AppTextStyles.appbarTextBig(context)),
          ],
        ),
      ),
    ],
  );
}
