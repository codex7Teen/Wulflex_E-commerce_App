import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/auth/presentation/widgets/forgot_password_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';

class ScreenForgotPassword extends StatefulWidget {
  const ScreenForgotPassword({super.key});

  @override
  State<ScreenForgotPassword> createState() => _ScreenForgotPasswordState();
}

class _ScreenForgotPasswordState extends State<ScreenForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _forgotPasswordEmailTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteThemeColor,
        ),
        backgroundColor: AppColors.whiteThemeColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child:
                    BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
                  listener: (context, state) {
                    if (state is PasswordResetSuccess) {
                      // Show-success snackbar
                      CustomSnackbar.showCustomSnackBar(context,
                          "Password reset link sent successfully....  🎉🎉🎉");
                    } else if (state is PasswordResetFailture) {
                      CustomSnackbar.showCustomSnackBar(
                          context, "Password reset failed!!!....  🎉🎉🎉",
                          icon: Icons.error_outline_rounded);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),

                      // image
                      ForgotPasswordWidgets.buildForgotPassImage(context),
                      SizedBox(height: 40),

                      // heading
                      ForgotPasswordWidgets.buildForgotPassText(),
                      SizedBox(height: 14),

                      ForgotPasswordWidgets.buildDontWorryText(),
                      SizedBox(height: 20),

                      // email textfield
                      ForgotPasswordWidgets.buildEmailTextField(
                          _forgotPasswordEmailTextController),
                      SizedBox(height: 35),

                      //! P A S S W O R D - R E S E T - B U T T O N
                      ForgotPasswordWidgets.buildResetButton(_formKey,
                          _forgotPasswordEmailTextController, context),
                      SizedBox(height: 22),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
