import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/delete_account_widgets.dart';
import 'package:wulflex/features/auth/presentation/screens/login_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
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
              CustomSnackbar.showCustomSnackBar(context, state.errorMessage,
                  icon: Icons.warning_rounded);
            } else if (state is DeleteAccountSuccess) {
              CustomSnackbar.showCustomSnackBar(
                  context, "Account deleted successfully...  🎉🎉🎉");
              NavigationHelper.navigateToWithReplacement(
                  context, const ScreenLogin());
              // Reset the checkboxes when account delete gets success
              context.read<DeleteAccountBloc>().add(ResetCheckboxStatesEvent());
            }
          },
          child: BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
            builder: (context, state) {
              if (state is DeleteAccountLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! WARNING MESSAGE
                    DeleteAccountScreenWidgets
                        .buildDeleteAccountWarmingContainer(),
                    const SizedBox(height: 28),

                    //! CONFIRMATION CHECKBOXES
                    DeleteAccountScreenWidgets.buildDeleteAccountWarningText(
                        context),
                    const SizedBox(height: 10),

                    BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
                      builder: (context, state) {
                        final checkBoxStates = state is DeleteAccountInitial
                            ? state.checkBoxStates
                            : [false, false, false, false];
                        return DeleteAccountScreenWidgets
                            .buildDeleteAccountCheckboxes(checkBoxStates);
                      },
                    ),

                    //! FINAL CONFIRMATION TEXT
                    DeleteAccountScreenWidgets
                        .buildSecondDeleteAccountWarningText(),
                    const SizedBox(height: 30),

                    //! CUSTOM DELETE BUTTON
                    DeleteAccountScreenWidgets.buildDeleteAccountButton(
                        context),
                    const SizedBox(height: 16),
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
