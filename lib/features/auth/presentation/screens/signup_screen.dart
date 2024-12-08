import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/features/auth/presentation/widgets/signup_widgets.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

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
                        // Sent data to firebase
                        final user = UserModel(
                            uid: state.userId,
                            name: _nameTextController.text.toString(),
                            email: state.emailId);
                        context
                            .read<UserProfileBloc>()
                            .add(CreateUserProfileEvent(user));
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
                        SignupWidgets.buildSignUpImage(context),
                        SizedBox(height: 30),

                        // heading
                        SignupWidgets.buildSignUpText(),
                        SizedBox(height: 14),

                        // Name textfield
                        SignupWidgets.buildNameTextField(_nameTextController),
                        SizedBox(height: 22),

                        // email textfield
                        SignupWidgets.buildEmaiTextField(_emailTextController),
                        SizedBox(height: 22),

                        // create password field
                        SignupWidgets.buildCreatePasswordTextField(
                            _createPasswordTextController,
                            _confirmPasswordTextController,
                            () => setState(() {
                                  _isCreatePasswordVisible =
                                      !_isCreatePasswordVisible;
                                }),
                            _isCreatePasswordVisible),
                        SizedBox(height: 22),

                        // confirm password field
                        SignupWidgets.buildConfirmPasswordTextField(
                            _createPasswordTextController,
                            _confirmPasswordTextController,
                            () => setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                }),
                            _isConfirmPasswordVisible),
                        SizedBox(height: 25),

                        // Terms and conditions
                        SignupWidgets.buildTermsAndConditonsText(),
                        SignupWidgets.buildPrivacyPolicyText(),
                        SizedBox(height: 22),

                        // ! S I G N U P - B U T T O N
                        SignupWidgets.buildSignUpButton(
                            _formKey,
                            context,
                            _emailTextController,
                            _confirmPasswordTextController),
                        SizedBox(height: 22),

                        // Already signed up? login
                        SignupWidgets.buildAlreadySignedUpAndLoginText(context),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }
}
