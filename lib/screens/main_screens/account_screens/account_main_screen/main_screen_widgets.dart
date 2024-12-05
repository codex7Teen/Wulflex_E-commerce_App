import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

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
