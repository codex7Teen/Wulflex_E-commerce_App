import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

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
                  child: isLoading ? Center(child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: AppColors.darkScaffoldColor,))) : Row(
                    children: [
                       SizedBox(width: 50),
                      Image.asset('assets/google_logo.png', width: 32),
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