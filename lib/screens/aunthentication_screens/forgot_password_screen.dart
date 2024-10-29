import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';
import 'package:wulflex/widgets/green_button_widget.dart';

class ScreenForgotPassword extends StatefulWidget {
  const ScreenForgotPassword({super.key});

  @override
  State<ScreenForgotPassword> createState() => _ScreenForgotPasswordState();
}

class _ScreenForgotPasswordState extends State<ScreenForgotPassword> {
  // key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // forgot password email controller
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
                                textStyle: AppTextStyles.headingLarge)
                            .copyWith(letterSpacing: 1)),
                    SizedBox(height: 14),

                    Text(
                      "Don't worry! It happens. Please enter the address associated with your account. We will sent you a password reset link.",
                      style: GoogleFonts.robotoCondensed(
                              textStyle: AppTextStyles.mediumText)
                          .copyWith(
                              color: AppColors.darkScaffoldColor,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                    // email textfield
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.alternate_email_rounded,
                            color: AppColors.greyThemeColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: TextFormField(
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
                                controller: _forgotPasswordEmailTextController,
                                decoration: InputDecoration(
                                    hintText: 'Email ID',
                                    hintStyle: GoogleFonts.robotoCondensed(
                                        textStyle: AppTextStyles.mediumText
                                            .copyWith(
                                                color: Colors.grey,
                                                letterSpacing: 0.5)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.greyThemeColor,
                                            width: 0.4))))),
                      ],
                    ),
                    SizedBox(height: 35),

                    // Submit Button
                    GestureDetector(
                        onTap: () {
                          _formKey.currentState!.validate();
                        },
                        child: GreenButtonWidget(buttonText: 'Submit')),
                    SizedBox(height: 22),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
