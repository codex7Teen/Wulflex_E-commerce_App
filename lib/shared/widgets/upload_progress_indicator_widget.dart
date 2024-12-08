import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/core/config/app_colors.dart';

Widget showUploadProgressIndicator(dynamic state) {
  return Container(
    height: 140,
    width: 140,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: state.progress,
          color: AppColors.greenThemeColor,
        ),
        SizedBox(height: 8),
        Text('${(state.progress * 100).toInt()}%',
            style: GoogleFonts.bebasNeue(
                color: AppColors.whiteThemeColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
                fontSize: 13.5)),
      ],
    ),
  );
}
