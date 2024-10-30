import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/screens/main_screens/home_screen.dart';
import 'package:wulflex/services/authentication/login_authorization.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/screens/aunthentication_screens/forgot_password_screen.dart';
import 'package:wulflex/screens/aunthentication_screens/signup_screen.dart';
import 'package:wulflex/widgets/google_button_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  // key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // email text controller
  final TextEditingController _emailTextController = TextEditingController();
  // password text controller
  final TextEditingController _passwordTextController = TextEditingController();
  // boolean for password visiblity
  bool _isPasswordVisible = false;
  // instance for auth services
  final _auth = AuthService();

  // disposed things when screen is moved from interface
  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(height: 20),

                    // image
                    Center(
                      child: Image.asset('assets/Login-green.png',
                          width: MediaQuery.sizeOf(context).width * 0.645),
                    ),
                    SizedBox(height: 30),

                    // heading
                    Text('Login',
                        style: GoogleFonts.bebasNeue(
                                textStyle: AppTextStyles.headingLarge)
                            .copyWith(letterSpacing: 1)),
                    SizedBox(height: 14),

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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                controller: _emailTextController,
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
                    SizedBox(height: 30),

                    // password field
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.greyThemeColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: TextFormField(
                                obscureText: !_isPasswordVisible,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                controller: _passwordTextController,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off_sharp
                                            : Icons.visibility,
                                        color: AppColors.greyThemeColor,
                                      ),
                                    ),
                                    hintText: 'Password',
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
                    SizedBox(height: 22),

                    // forgot password
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ScreenForgotPassword(),
                            transitionDuration: Duration(milliseconds: 400),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          ));
                        },
                        child: Text('Forgot Password?',
                            style: GoogleFonts.robotoCondensed(
                              textStyle: AppTextStyles.mediumText.copyWith(
                                  color: AppColors.greenThemeColor,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(height: 22),

                    // Login Button
                    GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _logIn();
                          }
                        },
                        child: GreenButtonWidget(buttonText: 'Login')),
                    SizedBox(height: 22),

                    // OR divider with lines
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                                color: AppColors.greyThemeColor,
                                thickness: 0.4)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'OR',
                            style: GoogleFonts.roboto(
                                textStyle: AppTextStyles.smallText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.greyThemeColor)),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                                color: AppColors.greyThemeColor,
                                thickness: 0.4))
                      ],
                    ),
                    SizedBox(height: 22),

                    // Google Button
                    GoogleButtonWidget(),
                    SizedBox(height: 22),

                    // New User. Sign-UP text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New to Wulflex?',
                          style: GoogleFonts.robotoCondensed(
                                  textStyle: AppTextStyles.mediumText)
                              .copyWith(
                                  color: AppColors.greyThemeColor,
                                  letterSpacing: 0.8),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ScreenSignUp(),
                            transitionDuration: Duration(milliseconds: 400),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          )),
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.robotoCondensed(
                                    textStyle: AppTextStyles.mediumText)
                                .copyWith(
                                    color: AppColors.greenThemeColor,
                                    letterSpacing: 0.8)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _logIn() async {
    final user = await _auth.loginUserWithEmailAndPassword(
        _emailTextController.text, _passwordTextController.text);
    if (user != null) {
      log('USER LOGGED IN SUCCESS');
      // Navigate to home
      if (mounted) {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ScreenHome(),
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ));
      }
    }
  }
}
