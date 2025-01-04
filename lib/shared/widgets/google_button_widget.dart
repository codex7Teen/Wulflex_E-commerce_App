import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

class GoogleButtonWidget extends StatelessWidget {
  final bool isLoading;
  const GoogleButtonWidget({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.sizeOf(context).width * 0.93,
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.lightGreyThemeColor),
                  child: isLoading ? const Center(child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: AppColors.blackThemeColor,))) : Row(
                    children: [
                       const SizedBox(width: 50),
                      Image.asset('assets/google_logo.png', width: 32),
                      const SizedBox(width: 37),
                      Text(
                        'Login with Google',
                        style: AppTextStyles.googleButtonStyle,
                      ),
                    ],
                  ),
                );
  }
}