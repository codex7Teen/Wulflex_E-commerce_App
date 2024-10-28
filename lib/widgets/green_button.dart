import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';

class GreenButtonWidget extends StatelessWidget {
  final String buttonText;
  const GreenButtonWidget({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.sizeOf(context).width * 0.93,
                  height: MediaQuery.sizeOf(context).height * 0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.greenThemeColor),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: GoogleFonts.robotoCondensed(
                          textStyle: AppTextStyles.greenButtonText).copyWith(letterSpacing: 1),
                    ),
                  ),
                );
  }
}