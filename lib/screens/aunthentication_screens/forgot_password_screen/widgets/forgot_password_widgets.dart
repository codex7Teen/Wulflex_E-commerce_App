import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';

Widget buildForgotPassImage(BuildContext context) {
  return Center(
    child: Image.asset('assets/Forgot password-cuate.png',
        width: MediaQuery.sizeOf(context).width * 0.645),
  );
}

Widget buildForgotPassText() {
  return Text('Forgot\nPassword?',
      style: GoogleFonts.bebasNeue(
              textStyle: AppTextStyles.headLineLarge
                  .copyWith(color: AppColors.darkScaffoldColor))
          .copyWith(letterSpacing: 1));
}

Widget buildDontWorryText() {
  return Text(
    "Don't worry! It happens. Please enter the address associated with your account. We will sent you a password reset link.",
    style: AppTextStyles.titleSmall.copyWith(
        color: AppColors.darkScaffoldColor, fontWeight: FontWeight.bold),
  );
}

Widget buildEmailTextField(TextEditingController forgotPasswordEmailTextController) {
  return CustomAuthenticationTetxfieldWidget(
                        controller: forgotPasswordEmailTextController,
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
                      );
}

Widget buildResetButton(GlobalKey<FormState> formkey, TextEditingController forgotPasswordEmailTextController, BuildContext context) {
  return GestureDetector(onTap: () {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<AuthenticatonBlocBloc>(context).add(
                              PasswordResetButtonPressed(
                                  email:
                                      forgotPasswordEmailTextController.text));
                        }
                      }, child: BlocBuilder<AuthenticatonBlocBloc,
                          AuthenticatonBlocState>(
                        builder: (context, state) {
                          return GreenButtonWidget(
                            buttonText: 'Submit',
                            isLoading: state is PasswordResetLoading,
                          );
                        },
                      ));
}



