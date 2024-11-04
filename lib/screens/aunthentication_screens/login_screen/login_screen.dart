// screen_login.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen/widgets/login_widgets.dart';
import 'package:wulflex/screens/main_screens/main_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

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
      backgroundColor: AppColors.lightScaffoldColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child:
                  BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
                listener: (context, state) {
                  if (state is LoginSuccess || state is GoogleLogInSuccess) {
                    // Show success snacbar
                    CustomSnackbar.showCustomSnackBar(
                        context, "Login success...  🎉🎉🎉");
                    // Navigate to Home
                    NavigationHelper.navigateToWithReplacement(
                        context, MainScreen());
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
                    buildLoginImage(context),
                    const SizedBox(height: 30),
                    buildLoginHeading(),
                    const SizedBox(height: 14),
                    buildEmailField(_emailTextController),
                    const SizedBox(height: 30),
                    buildPasswordField(
                        _passwordTextController, _isPasswordVisible, () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }),
                    const SizedBox(height: 22),
                    buildForgotPasswordLink(context),
                    const SizedBox(height: 22),
                    buildLoginButton(context, _formKey, _emailTextController,
                        _passwordTextController),
                    const SizedBox(height: 22),
                    // OR divider with lines
                    buildOrDivider(),
                    const SizedBox(height: 22),
                    buildGoogleLoginButton(context),
                    const SizedBox(height: 22),
                    buildSignUpLink(context),
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
