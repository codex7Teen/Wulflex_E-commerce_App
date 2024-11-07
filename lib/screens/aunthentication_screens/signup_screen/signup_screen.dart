import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/signup_screen/widgets/signup_widgets.dart';
import 'package:wulflex/screens/main_screens/main_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

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
        backgroundColor: AppColors.whiteThemeColor,
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
                            context, MainScreen());
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
                        buildSignUpImage(context),
                        SizedBox(height: 30),

                        // heading
                        buildSignUpText(),
                        SizedBox(height: 14),

                        // Name textfield
                        buildNameTextField(_nameTextController),
                        SizedBox(height: 22),

                        // email textfield
                        buildEmaiTextField(_emailTextController),
                        SizedBox(height: 22),

                        // create password field
                        buildCreatePasswordTextField(
                            _createPasswordTextController,
                            _confirmPasswordTextController,
                            () => setState(() {
                                  _isCreatePasswordVisible =
                                      !_isCreatePasswordVisible;
                                }),
                            _isCreatePasswordVisible),
                        SizedBox(height: 22),

                        // confirm password field
                        buildConfirmPasswordTextField(
                            _createPasswordTextController,
                            _confirmPasswordTextController,
                            () => setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                }),
                            _isConfirmPasswordVisible),
                        SizedBox(height: 25),

                        // Terms and conditions
                        buildTermsAndConditonsText(),
                        buildPrivacyPolicyText(),
                        SizedBox(height: 22),

                        // ! S I G N U P - B U T T O N
                        buildSignUpButton(_formKey, context, _emailTextController, _confirmPasswordTextController),
                        SizedBox(height: 22),

                        // Already signed up? login
                        buildAlreadySignedUpAndLoginText(context),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
