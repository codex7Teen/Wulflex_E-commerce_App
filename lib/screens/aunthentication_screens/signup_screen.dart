import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/main_screens/home_screen/home_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen.dart';
import 'package:wulflex/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _createPasswordTextController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();
  // boolean for password visiblity
  bool _isCreatePasswordVisible = false;
  // boolean for password visiblity
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _emailTextController.dispose();
    _createPasswordTextController.dispose();
    _confirmPasswordTextController.dispose();
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
                  child: BlocListener<AuthenticatonBlocBloc,
                      AuthenticatonBlocState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        // Show successnacbar
                        CustomSnackbar.showCustomSnackBar(
                            context, "Sign-Up success...  🎉🎉🎉");
                        // Navigate to Home
                        NavigationHelper.navigateToWithReplacement(
                            context, ScreenHome());
                      } else if (state is SignUpFailture) {
                        // show-snacbar
                        CustomSnackbar.showCustomSnackBar(context, state.error,
                            icon: Icons.error_outline_rounded);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),

                        // image
                        Center(
                          child: Image.asset('assets/signup_illustric.png',
                              width: MediaQuery.sizeOf(context).width * 0.645),
                        ),
                        SizedBox(height: 30),

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
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                        CustomAuthenticationTetxfieldWidget(
                          controller: _emailTextController,
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
                        SizedBox(height: 22),

                        // create password field
                        CustomAuthenticationTetxfieldWidget(
                          controller: _createPasswordTextController,
                          hintText: 'Create password',
                          icon: Icons.lock_outline_rounded,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            // minimum 8 characters
                            if (value.trim().length < 8) {
                              return 'Password should be at least 8 characters';
                            }
                            // password mismatch
                            if (_createPasswordTextController.text !=
                                    _confirmPasswordTextController.text &&
                                _confirmPasswordTextController
                                    .text.isNotEmpty) {
                              return "Both passwords doesn't match";
                            }
                            return null;
                          },
                          toggleVisibility: () => setState(() {
                            _isCreatePasswordVisible =
                                !_isCreatePasswordVisible;
                          }),
                          isPasswordVisible: _isCreatePasswordVisible,
                          obscureText: true,
                        ),
                        SizedBox(height: 22),

                        // confirm password field
                        CustomAuthenticationTetxfieldWidget(
                          controller: _confirmPasswordTextController,
                          hintText: 'Confirm password',
                          icon: Icons.lock_outline_rounded,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            // minimum 8 characters
                            if (value.trim().length < 8) {
                              return 'Password should be at least 8 characters';
                            }
                            // password mismatch
                            if (_createPasswordTextController.text !=
                                    _confirmPasswordTextController.text &&
                                _createPasswordTextController.text.isNotEmpty) {
                              return "Both passwords doesn't match";
                            }
                            return null;
                          },
                          obscureText: true,
                          isPasswordVisible: _isConfirmPasswordVisible,
                          toggleVisibility: () => setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          }),
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

                        // ! S I G N U P - B U T T O N
                        GestureDetector(onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthenticatonBlocBloc>(context).add(
                                SignUpButtonPressed(
                                    email: _emailTextController.text,
                                    password:
                                        _confirmPasswordTextController.text));
                          }
                        }, child: BlocBuilder<AuthenticatonBlocBloc,
                            AuthenticatonBlocState>(
                          builder: (context, state) {
                            // shows loading when state is loading
                            return GreenButtonWidget(
                              buttonText: 'Submit',
                              isLoading: state is SignUpLoading,
                            );
                          },
                        )),
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
                              onTap: () =>
                                  NavigationHelper.navigateToWithReplacement(
                                      context, ScreenLogin()),
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
                  )),
            ),
          ),
        ));
  }
}
