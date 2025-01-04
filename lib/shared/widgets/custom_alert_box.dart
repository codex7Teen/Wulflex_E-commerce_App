import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/core/config/app_colors.dart';

class CustomAlertBox {
  static Future<void> showConfirmationAlertDialog(BuildContext context,
      {required VoidCallback onDeleteConfirmed,
      required String titleText,
      required String buttonConfirmText,
      IconData icon = Icons.delete}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: AppColors.lightGreyThemeColor,
          title: Text(
            'Are you sure?',
            style: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.bold,
              color: AppColors.blackThemeColor,
              fontSize: 22,
              letterSpacing: 1,
            ),
          ),
          content: Text(
            titleText,
            style: GoogleFonts.robotoCondensed(
              color: AppColors.darkishGrey,
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blackThemeColor,
                backgroundColor: AppColors.lightGreyThemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackThemeColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    buttonConfirmText,
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onDeleteConfirmed();
              },
            ),
          ],
        );
      },
    );
  }
}
