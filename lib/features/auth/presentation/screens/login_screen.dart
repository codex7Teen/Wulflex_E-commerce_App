// screen_login.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/services/notification_services.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/features/auth/presentation/widgets/login_widgets.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
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
              child:
                  BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
                listener: (context, state) {
                  if (state is LoginSuccess ||
                      state is GoogleFirstLoginSuccess ||
                      state is GoogleLogInSuccess) {
                    // Save user details to firebase when user login for first time
                    if (state is GoogleFirstLoginSuccess) {
                      context.read<UserProfileBloc>().add(
                          CreateUserProfileEvent(UserModel(
                              uid: state.userId,
                              name: state.name,
                              email: state.emailId)));
                    }
                    // Upload the FCM token to firebase firestore
                    NotificationServices().uploadFcmToken();
                    // Show success snacbar
                    CustomSnackbar.showCustomSnackBar(
                        context, "Login success... 🎉🎉🎉");
                    // Navigate to Home
                    Future.delayed(const Duration(seconds: 1), () {
                      if (context.mounted) {
                        NavigationHelper.navigateToWithReplacement(
                            context, const MainScreen());
                      }
                    });
                  } else if (state is LoginFailture) {
                    // show failed snacbar
                    CustomSnackbar.showCustomSnackBar(context, state.error,
                        icon: Icons.error_outline_rounded);
                  } else if (state is GoogleLogInFailture) {
                    // show failed snacbar
                    CustomSnackbar.showCustomSnackBar(context, state.error,
                        icon: Icons.error_outline_rounded);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    LoginWidgets.buildLoginImage(context),
                    const SizedBox(height: 30),
                    LoginWidgets.buildLoginHeading(context),
                    const SizedBox(height: 14),
                    LoginWidgets.buildEmailField(_emailTextController),
                    const SizedBox(height: 30),
                    LoginWidgets.buildPasswordField(
                        _passwordTextController, _isPasswordVisible, () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }),
                    const SizedBox(height: 22),
                    LoginWidgets.buildForgotPasswordLink(context),
                    const SizedBox(height: 22),
                    LoginWidgets.buildLoginButton(context, _formKey,
                        _emailTextController, _passwordTextController),
                    const SizedBox(height: 22),
                    // OR divider with lines
                    LoginWidgets.buildOrDivider(),
                    const SizedBox(height: 22),
                    LoginWidgets.buildGoogleLoginButton(context),
                    const SizedBox(height: 22),
                    LoginWidgets.buildSignUpLink(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
