import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/bloc/relogin_bloc/relogin_bloc.dart';
import 'package:wulflex/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/shared/widgets/google_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ReloginScreenWidget {
  static Widget buildLoginImage(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/login_img.png',
        width: MediaQuery.sizeOf(context).width * 0.645,
      ),
    );
  }

  static Widget buildLoginHeading(BuildContext context) {
    return Text(
      'Re-login to continue...',
      style: AppTextStyles.authenticationHeadings(context, fixedBlackColor: false),
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
    return GestureDetector(onTap: () {
      if (formKey.currentState!.validate()) {
        // relogin
        context.read<ReloginBloc>().add(ReloginUsingEmailAndPasswordEvent(
            email: emailController.text.trim(),
            password: passwordController.text.trim()));
      }
    }, child: BlocBuilder<ReloginBloc, ReloginState>(
      builder: (context, state) {
        return GreenButtonWidget(
          buttonText: 'Re-Login',
          isLoading: state is ReloginLoading,
          borderRadius: 15,
        );
      },
    ));
  }

  static Widget buildGoogleLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // google login
        context.read<ReloginBloc>().add(ReloginUsingGoogleEvent());
      },
      child: BlocBuilder<ReloginBloc, ReloginState>(
        builder: (context, state) {
          return GoogleButtonWidget(isLoading: state is GoogleLoading);
        },
      ),
    );
  }
}
