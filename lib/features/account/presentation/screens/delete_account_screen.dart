import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/features/auth/presentation/screens/login_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_black_button_widget.dart';
import 'package:wulflex/features/account/presentation/widgets/delete_account_widgets.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenDeleteAccount extends StatelessWidget {
  const ScreenDeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'Delete Account', 0.05),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 25),
        child: BlocListener<DeleteAccountBloc, DeleteAccountState>(
          listener: (context, state) {
            if (state is DeleteAccountFailure) {
              CustomSnackbar.showCustomSnackBar(
                  context, state.errorMessage,
                  icon: Icons.warning_rounded);
            } else if (state is DeleteAccountSuccess) {
              CustomSnackbar.showCustomSnackBar(
                  context, "Account deleted successfully...  🎉🎉🎉");
              NavigationHelper.navigateToWithReplacement(
                  context, ScreenLogin());
              // Reset the checkboxes when account delete gets success
              context.read<DeleteAccountBloc>().add(ResetCheckboxStatesEvent());
            }
          },
          child: BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
            builder: (context, state) {
              if (state is DeleteAccountLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Warning Message
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_rounded, color: Colors.red),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Your Wulflex account will be permanently deleted. This action cannot be undone.",
                              style: AppTextStyles.delteAccountRedWarningText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28),

                    // Confirmation Checkboxes
                    Text("Please confirm that you understand:",
                        style: AppTextStyles.pleaseConfirmText(context)),
                    SizedBox(height: 10),

                    BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
                      builder: (context, state) {
                        final checkBoxStates = state is DeleteAccountInitial
                            ? state.checkBoxStates
                            : [false, false, false, false];
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
                                    style: AppTextStyles.confimationLinesText(
                                        context)),
                                value: checkBoxStates[index],
                                onChanged: (value) => context
                                    .read<DeleteAccountBloc>()
                                    .add(ToggleCheckboxEvent(
                                        index, value ?? false)),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    // Final Confirmation Text
                    Text(
                      "By clicking \"Delete Account Permanently\" you acknowledge that you have read and understand the consequences of account deletion.",
                      style: AppTextStyles.deleteAccountAcknowledgeText,
                    ),
                    SizedBox(height: 30),

                    // Your Custom Delete Button
                    GestureDetector(
                      onTap: () {
                        final currentStates =
                            context.read<DeleteAccountBloc>().state;
                        if (currentStates is DeleteAccountInitial &&
                            currentStates.checkBoxStates
                                .every((state) => state)) {
                          // Show confirmation alert
                          showCustomWarningAlertBox(context);
                        } else {
                          // trigger snackbar
                          CustomSnackbar.showCustomSnackBar(
                              context, "Please check the fields!",
                              icon: Icons.warning_rounded);
                        }
                      },
                      child: Center(
                        child: CustomBlackButtonWidget(
                          buttonText: "Delete Account Permanently",
                          borderRadius: 25,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
