import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:wulflex/features/auth/presentation/screens/signup_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/shared/widgets/google_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class LoginWidgets {
  static Widget buildLoginImage(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/login_img.png',
        width: MediaQuery.sizeOf(context).width * 0.645,
      ),
    );
  }

  static Widget buildLoginHeading() {
    return Text(
      'Login',
      style: AppTextStyles.authenticationHeadings,
    );
  }

  static Widget buildEmailField(TextEditingController controller) {
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

  static Widget buildPasswordField(TextEditingController controller,
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

  static Widget buildForgotPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          NavigationHelper.navigateToWithoutReplacement(
              context, ScreenForgotPassword());
        },
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.forgotPasswordStyle,
        ),
      ),
    );
  }

  static Widget buildLoginButton(
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
            borderRadius: 15,
          );
        },
      ),
    );
  }

  static Widget buildGoogleLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AuthenticatonBlocBloc>(context)
            .add(GoogleLoginPressed());
      },
      child: BlocBuilder<AuthenticatonBlocBloc, AuthenticatonBlocState>(
        builder: (context, state) {
          return GoogleButtonWidget(isLoading: state is GoogleLogInLoading);
        },
      ),
    );
  }

  static Widget buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('New to Wulflex?',
            style: AppTextStyles.newToWulflexOrAlreadyHaveAccountText),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            NavigationHelper.navigateToWithReplacement(context, ScreenSignUp());
          },
          child: Text(
            'Sign up',
            style: AppTextStyles.signUpAndLoginGreenText,
          ),
        ),
      ],
    );
  }

  static Widget buildOrDivider() {
    return Row(
      children: [
        Expanded(
            child: Divider(color: AppColors.greyThemeColor, thickness: 0.4)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: AppTextStyles.orDividerText,
          ),
        ),
        Expanded(
            child: Divider(color: AppColors.greyThemeColor, thickness: 0.4))
      ],
    );
  }
}
