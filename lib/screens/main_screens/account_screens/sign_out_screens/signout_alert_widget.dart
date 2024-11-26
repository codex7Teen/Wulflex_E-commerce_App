import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/blocs/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/screens/main_screens/main_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

void showCustomSignoutWarningAlertBox(BuildContext context) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.custom,
    showCancelBtn: true,
    confirmBtnText: 'Signout',
    widget: Text(
        textAlign: TextAlign.center,
        'Are you sure you want to Sign-out? 💔\n',
        style: GoogleFonts.robotoCondensed(
            textStyle: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w500,
                color: AppColors.blackThemeColor))),
    cancelBtnTextStyle: GoogleFonts.robotoCondensed(
        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.blackThemeColor)),
    confirmBtnTextStyle: GoogleFonts.robotoCondensed(
        textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.redThemeColor)),
    confirmBtnColor: AppColors.blackThemeColor,
    customAsset: 'assets/warning.jpg',
    autoCloseDuration: Duration(seconds: 3),
    width: 120,
    onConfirmBtnTap: () {
      context.read<AuthenticatonBlocBloc>().add(LogOutButtonPressed());
      currentIndex = 0;
      Navigator.pop(context);
    },
  );
}
