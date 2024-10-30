import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class GreenButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  const GreenButtonWidget(
      {super.key, required this.buttonText, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.89,
      height: MediaQuery.sizeOf(context).height * 0.065,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.greenThemeColor),
      child: Center(
        // show loading indication when some state is loading
        child: isLoading
            ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: AppColors.lightScaffoldColor,))
            : Text(
                buttonText,
                style: GoogleFonts.robotoCondensed(
                        textStyle: AppTextStyles.greenButtonText)
                    .copyWith(letterSpacing: 1),
              ),
      ),
    );
  }
}
