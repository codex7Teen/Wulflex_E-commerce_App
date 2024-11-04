// login_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:wulflex/screens/aunthentication_screens/signup_screen/signup_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/widgets/google_button_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

Widget buildLoginImage(BuildContext context) {
  return Center(
    child: Image.asset(
      'assets/Login-green.png',
      width: MediaQuery.sizeOf(context).width * 0.645,
    ),
  );
}

Widget buildLoginHeading() {
  return Text(
    'Login',
    style: AppTextStyles.headLineLarge
        .copyWith(color: AppColors.darkScaffoldColor),
  );
}

Widget buildEmailField(TextEditingController controller) {
  return CustomAuthenticationTetxfieldWidget(
    controller: controller,
    hintText: 'Email ID',
    icon: Icons.alternate_email_rounded,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter your email address';
      }
      final RegExp emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    },
  );
}

Widget buildPasswordField(TextEditingController controller,
    bool isPasswordVisible, VoidCallback toggleVisibility) {
  return CustomAuthenticationTetxfieldWidget(
    controller: controller,
    hintText: 'Password',
    icon: Icons.lock_outline_rounded,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter your password';
      }
      return null;
    },
    isPasswordVisible: isPasswordVisible,
    toggleVisibility: toggleVisibility,
    obscureText: true,
  );
}

Widget buildForgotPasswordLink(BuildContext context) {
  return Align(
    alignment: Alignment.topRight,
    child: GestureDetector(
      onTap: () {
        NavigationHelper.navigateToWithoutReplacement(
            context, ScreenForgotPassword());
      },
      child: Text(
        'Forgot Password?',
        style: AppTextStyles.titleSmall.copyWith(
          color: AppColors.greenThemeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildLoginButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return GestureDetector(
    onTap: () {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<AuthenticatonBlocBloc>(context).add(
          LoginButtonPressed(
              email: emailController.text, password: passwordController.text),
        );
      }
    },
    child: BlocBuilder<AuthenticatonBlocBloc, AuthenticatonBlocState>(
      builder: (context, state) {
        return GreenButtonWidget(
          buttonText: 'Login',
          isLoading: state is LoginLoading,
        );
      },
    ),
  );
}

Widget buildGoogleLoginButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<AuthenticatonBlocBloc>(context).add(GoogleLoginPressed());
    },
    child: BlocBuilder<AuthenticatonBlocBloc, AuthenticatonBlocState>(
      builder: (context, state) {
        return GoogleButtonWidget(isLoading: state is GoogleLogInLoading);
      },
    ),
  );
}

Widget buildSignUpLink(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('New to Wulflex?', style: AppTextStyles.titleSmall),
      const SizedBox(width: 5),
      GestureDetector(
        onTap: () {
          NavigationHelper.navigateToWithReplacement(context, ScreenSignUp());
        },
        child: Text(
          'Sign up',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.greenThemeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget buildOrDivider() {
  return Row(
    children: [
      Expanded(child: Divider(color: AppColors.greyThemeColor, thickness: 0.4)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'OR',
          style: AppTextStyles.titleXSmall
              .copyWith(color: AppColors.greyThemeColor),
        ),
      ),
      Expanded(child: Divider(color: AppColors.greyThemeColor, thickness: 0.4))
    ],
  );
}
