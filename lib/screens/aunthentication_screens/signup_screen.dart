import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen.dart';
import 'package:wulflex/widgets/green_button_widget.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  // key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // name text controller
  final TextEditingController _nameTextController = TextEditingController();
  // email text controller
  final TextEditingController _emailTextController = TextEditingController();
  // create password text controller
  final TextEditingController _createPasswordTextController =
      TextEditingController();
  // confirm password text controller
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

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
                    SizedBox(height: 15),

                    // image
                    Center(
                      child: Image.asset('assets/signup_illustric.png',
                          width: MediaQuery.sizeOf(context).width * 0.645),
                    ),
                    SizedBox(height: 40),

                    // heading
                    Text('SIGN UP',
                        style: GoogleFonts.bebasNeue(
                                textStyle: AppTextStyles.headingLarge)
                            .copyWith(letterSpacing: 1)),
                    SizedBox(height: 14),

                    // Name textfield
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.person,
                            color: AppColors.greyThemeColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  // empty validation
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                controller: _nameTextController,
                                decoration: InputDecoration(
                                    hintText: 'Full name',
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
                    SizedBox(height: 22),

                    // create password field
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
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty) {
                                  return 'Please enter your password';
                                }
                                // password mismatch
                                if(_createPasswordTextController.text != _confirmPasswordTextController.text && _confirmPasswordTextController.text.isNotEmpty) {
                                  return "Both passwords doesn't match";
                                }
                                return null;
                              },
                              controller: _createPasswordTextController,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.visibility_off_sharp,
                                      color: AppColors.greyThemeColor,
                                    ),
                                    hintText: 'Create password',
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

                    // confirm password field
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
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty) {
                                  return 'Please enter your password';
                                }
                                // password mismatch
                                if(_createPasswordTextController.text != _confirmPasswordTextController.text && _createPasswordTextController.text.isNotEmpty) {
                                  return "Both passwords doesn't match";
                                }
                                return null;
                              },
                              controller: _confirmPasswordTextController,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.visibility_off_sharp,
                                      color: AppColors.greyThemeColor,
                                    ),
                                    hintText: 'Confirm password',
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
                    SizedBox(height: 25),

                    // Terms and conditions
                    Row(
                      children: [
                        Text(
                          "By signing up, you're agreeing to our",
                          style: GoogleFonts.robotoCondensed(
                              textStyle: AppTextStyles.smallText.copyWith(
                                  color: Colors.grey, letterSpacing: 0.6)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Terms & Conditions",
                          style: GoogleFonts.robotoCondensed(
                              textStyle: AppTextStyles.smallText.copyWith(
                                  color: AppColors.greenThemeColor,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "and",
                          style: GoogleFonts.robotoCondensed(
                              textStyle: AppTextStyles.smallText.copyWith(
                                  color: Colors.grey, letterSpacing: 0.6)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Privacy Policy",
                          style: GoogleFonts.robotoCondensed(
                              textStyle: AppTextStyles.smallText.copyWith(
                                  color: AppColors.greenThemeColor,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),

                    // Submit Button
                    GestureDetector(
                      onTap: () {
                        _formKey.currentState!.validate();
                      },
                        child: GreenButtonWidget(buttonText: 'Submit')),
                    SizedBox(height: 22),

                    // Already signed up? login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
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
                                    ScreenLogin(),
                            transitionDuration: Duration(milliseconds: 400),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          )),
                          child: Text(
                            'Login',
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
}
