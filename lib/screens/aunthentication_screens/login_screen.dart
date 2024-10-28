import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';
import 'package:wulflex/widgets/google_button.dart';
import 'package:wulflex/widgets/green_button.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightScaffoldColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),

                  // image
                  Center(
                    child: Image.asset('assets/login_illustric.png',
                        width: MediaQuery.sizeOf(context).width * 0.645),
                  ),
                  SizedBox(height: 40),

                  // heading
                  Text('Login',
                      style: GoogleFonts.bebasNeue(
                          textStyle: AppTextStyles.headingLarge).copyWith(letterSpacing: 1)),
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
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.visibility_off_sharp,
                                    color: AppColors.greyThemeColor,
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
                    child: Text('Forgot Password?',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: AppTextStyles.mediumText.copyWith(
                              color: AppColors.greenThemeColor,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(height: 22),

                  // Login Button
                  GreenButtonWidget(buttonText: 'Login'),
                  SizedBox(height: 22),

                  // OR divider with lines
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color: AppColors.greyThemeColor, thickness: 0.4)),
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
                              color: AppColors.greyThemeColor, thickness: 0.4))
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
                            .copyWith(color: AppColors.greyThemeColor, letterSpacing: 1),
                      ),
                      SizedBox(width: 5),
                       Text(
                        'Register',
                        style: GoogleFonts.robotoCondensed(
                                textStyle: AppTextStyles.mediumText)
                            .copyWith(color: AppColors.greenThemeColor, letterSpacing: 1).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
