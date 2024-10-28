import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/consts/app_colors.dart';
import 'package:wulflex/consts/text_styles.dart';

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
                        width: MediaQuery.sizeOf(context).width * 0.65),
                  ),
                  SizedBox(height: 40),
          
                  // heading
                  Text('Login',
                      style: GoogleFonts.bebasNeue(
                          textStyle: AppTextStyles.headingLarge)),
          
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
                                suffixIcon: Icon(Icons.visibility_off_sharp, color: AppColors.greyThemeColor,),
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
                  SizedBox(height: 60)
                ],
              ),
            ),
          ),
        ));
  }
}
