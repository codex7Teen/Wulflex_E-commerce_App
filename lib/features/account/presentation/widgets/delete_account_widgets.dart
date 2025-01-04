import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_black_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';

class DeleteAccountScreenWidgets {
  static void showCustomWarningAlertBox(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      showCancelBtn: true,
      confirmBtnText: 'Delete',
      widget: Text(
          textAlign: TextAlign.center,
          'Are you sure you want to erase your \naccount forever? 💔\n',
          style: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackThemeColor))),
      cancelBtnTextStyle: GoogleFonts.robotoCondensed(
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackThemeColor)),
      confirmBtnTextStyle: GoogleFonts.robotoCondensed(
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.redThemeColor)),
      confirmBtnColor: AppColors.blackThemeColor,
      customAsset: 'assets/warning.jpg',
      autoCloseDuration: const Duration(seconds: 3),
      width: 120,
      onConfirmBtnTap: () {
        context.read<DeleteAccountBloc>().add(DeleteAccountButtonPressed());
        Navigator.pop(context);
      },
    );
  }

  static Widget buildDeleteAccountWarmingContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Your Wulflex account will be permanently deleted. This action cannot be undone.",
              style: AppTextStyles.delteAccountRedWarningText,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildDeleteAccountWarningText(BuildContext context) {
    return Text("Please confirm that you understand:",
        style: AppTextStyles.pleaseConfirmText(context));
  }

  static Widget buildDeleteAccountCheckboxes(List<bool> checkBoxStates) {
    return SizedBox(
      height: 285,
      child: ListView.builder(
        itemCount: checkBoxStates.length,
        itemBuilder: (context, index) {
          final titles = [
            "All your order history and saved items will be permanently deleted",
            "Your saved addresses and payment methods will be removed",
            "You will lose access to your Wulflex commitments and benefits",
            "Your fitness tracking data and workout plans will be erased"
          ];
          return CheckboxListTile(
            title: Text(titles[index],
                style: AppTextStyles.confimationLinesText(context)),
            value: checkBoxStates[index],
            onChanged: (value) => context
                .read<DeleteAccountBloc>()
                .add(ToggleCheckboxEvent(index, value ?? false)),
          );
        },
      ),
    );
  }

  static Widget buildSecondDeleteAccountWarningText() {
    return Text(
      "By clicking \"Delete Account Permanently\" you acknowledge that you have read and understand the consequences of account deletion.",
      style: AppTextStyles.deleteAccountAcknowledgeText,
    );
  }

  static Widget buildDeleteAccountButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentStates = context.read<DeleteAccountBloc>().state;
        if (currentStates is DeleteAccountInitial &&
            currentStates.checkBoxStates.every((state) => state)) {
          // Show confirmation alert
          showCustomWarningAlertBox(context);
        } else {
          // trigger snackbar
          CustomSnackbar.showCustomSnackBar(context, "Please check the fields!",
              icon: Icons.warning_rounded);
        }
      },
      child: const Center(
        child: CustomBlackButtonWidget(
          buttonText: "Delete Account Permanently",
          borderRadius: 25,
        ),
      ),
    );
  }
}
