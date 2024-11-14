import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

PreferredSizeWidget customAppbarWithBackbutton(BuildContext context, String appbarTitle) {
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
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteThemeColor),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.blackThemeColor),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.178),
            Text(appbarTitle, style: AppTextStyles.appbarTextBig(context)),
          ],
        ),
      ),
    ],
  );
}
