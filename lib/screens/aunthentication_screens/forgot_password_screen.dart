import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';

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
          backgroundColor: AppColors.lightScaffoldColor,
        ),
        backgroundColor: AppColors.lightScaffoldColor,
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
                      Center(
                        child: Image.asset('assets/Forgot password-cuate.png',
                            width: MediaQuery.sizeOf(context).width * 0.645),
                      ),
                      SizedBox(height: 40),

                      // heading
                      Text('Forgot\nPassword?',
                          style: GoogleFonts.bebasNeue(
                                  textStyle: AppTextStyles.headLineLarge.copyWith(color: AppColors.darkScaffoldColor))
                              .copyWith(letterSpacing: 1)),
                      SizedBox(height: 14),

                      Text(
                        "Don't worry! It happens. Please enter the address associated with your account. We will sent you a password reset link.",
                        style: AppTextStyles.titleSmall.copyWith(
                                  color: AppColors.darkScaffoldColor,
                                  fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),

                      // email textfield
                      CustomAuthenticationTetxfieldWidget(
                        controller: _forgotPasswordEmailTextController,
                        hintText: 'Email ID',
                        icon: Icons.alternate_email_rounded,
                        validator: (value) {
                          // Check if the field is empty
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter you email address';
                          }
                          // regular expression for email format
                          final RegExp emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          // Checking if the email matches the regular expression
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35),

                      //! P A S S W O R D - R E S E T - B U T T O N
                      GestureDetector(onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenticatonBlocBloc>(context).add(
                              PasswordResetButtonPressed(
                                  email:
                                      _forgotPasswordEmailTextController.text));
                        }
                      }, child: BlocBuilder<AuthenticatonBlocBloc,
                          AuthenticatonBlocState>(
                        builder: (context, state) {
                          return GreenButtonWidget(
                            buttonText: 'Submit',
                            isLoading: state is PasswordResetLoading,
                          );
                        },
                      )),
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
