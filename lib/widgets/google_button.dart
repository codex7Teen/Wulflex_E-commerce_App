import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.sizeOf(context).width * 0.93,
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.lightGreyThemeColor),
                  child: Row(
                    children: [
                       SizedBox(width: 50),
                      Image.asset('assets/pngwing.com.png', width: 32),
                      SizedBox(width: 37),
                      Text(
                        'Login with Google',
                        style: GoogleFonts.robotoCondensed(
                            textStyle: AppTextStyles.greenButtonText).copyWith(color: AppColors.darkScaffoldColor, letterSpacing: 1),
                      ),
                    ],
                  ),
                );
  }
}