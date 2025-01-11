import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/presentation/screens/privacy_policy_screen.dart';
import 'package:wulflex/features/account/presentation/screens/terms_and_conditions_screen.dart';
import 'package:wulflex/features/auth/bloc/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/features/auth/presentation/screens/login_screen.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class SignupWidgets {
  static Widget buildSignUpImage(BuildContext context) {
    return Center(
      child: Image.asset('assets/signup_illustric.png',
          width: MediaQuery.sizeOf(context).width * 0.645),
    );
  }

  static Widget buildSignUpText(BuildContext context) {
    return Text('SIGN UP',
        style: AppTextStyles.authenticationHeadings(context));
  }

  static Widget buildNameTextField(TextEditingController nameTextController) {
    return CustomAuthenticationTetxfieldWidget(
      controller: nameTextController,
      hintText: "Full name",
      icon: Icons.person,
      validator: (value) {
        // empty validation
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  static Widget buildEmaiTextField(TextEditingController emailController) {
    return CustomAuthenticationTetxfieldWidget(
      controller: emailController,
      hintText: 'Email ID',
      icon: Icons.alternate_email_rounded,
      validator: (value) {
        // Check if the field is empty
        if (value == null || value.trim().isEmpty) {
          return 'Please enter you email address';
        }
        // regular expression for email format
        final RegExp emailRegex =
            RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        // Checking if the email matches the regular expression
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  static Widget buildCreatePasswordTextField(
      TextEditingController createPasswordTextController,
      TextEditingController confirmPasswordTextController,
      VoidCallback toggleVisibility,
      bool isPasswordVisible) {
    return CustomAuthenticationTetxfieldWidget(
      controller: createPasswordTextController,
      hintText: 'Create password',
      icon: Icons.lock_outline_rounded,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your password';
        }
        if (value.trim().length < 8) {
          return 'Password should be at least 8 characters';
        }
        if (createPasswordTextController.text !=
                confirmPasswordTextController.text &&
            confirmPasswordTextController.text.isNotEmpty) {
          return "Both passwords doesn't match";
        }
        return null;
      },
      toggleVisibility: toggleVisibility,
      isPasswordVisible: isPasswordVisible,
      obscureText: true,
    );
  }

  static Widget buildConfirmPasswordTextField(
      TextEditingController createPasswordTextController,
      TextEditingController confirmPasswordTextController,
      VoidCallback toggleVisibility,
      bool isPasswordVisible) {
    return CustomAuthenticationTetxfieldWidget(
        controller: confirmPasswordTextController,
        hintText: 'Confirm password',
        icon: Icons.lock_outline_rounded,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your password';
          }
          if (value.trim().length < 8) {
            return 'Password should be at least 8 characters';
          }
          if (createPasswordTextController.text !=
                  confirmPasswordTextController.text &&
              createPasswordTextController.text.isNotEmpty) {
            return "Both passwords doesn't match";
          }
          return null;
        },
        obscureText: true,
        isPasswordVisible: isPasswordVisible,
        toggleVisibility: toggleVisibility);
  }

  static Widget buildTermsAndConditonsText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "By signing up, you're agreeing to our",
            style: AppTextStyles.termsAndConditionAndPrivacyPolicyBaseText,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => NavigationHelper.navigateToWithoutReplacement(
              context, const TermsAndConditionsScreen()),
          child: Text("Terms & Conditions",
              style: AppTextStyles.termsAndConditionAndPrivacyPolicyGreenText),
        ),
      ],
    );
  }

  static Widget buildPrivacyPolicyText(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Text(
          "and",
          style: AppTextStyles.termsAndConditionAndPrivacyPolicyBaseText,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => NavigationHelper.navigateToWithoutReplacement(
              context, const PrivacyPolicyScreen()),
          child: Text(
            "Privacy Policy",
            style: AppTextStyles.termsAndConditionAndPrivacyPolicyGreenText,
          ),
        ),
      ],
    );
  }

  static Widget buildSignUpButton(
      GlobalKey<FormState> formkey,
      BuildContext context,
      TextEditingController emailTextController,
      TextEditingController confirmPasswordTextController) {
    return GestureDetector(onTap: () {
      if (formkey.currentState!.validate()) {
        BlocProvider.of<AuthenticatonBlocBloc>(context).add(SignUpButtonPressed(
            email: emailTextController.text,
            password: confirmPasswordTextController.text));
      }
    }, child: BlocBuilder<AuthenticatonBlocBloc, AuthenticatonBlocState>(
      builder: (context, state) {
        // shows loading when state is loading
        return GreenButtonWidget(
          buttonText: 'Submit',
          isLoading: state is SignUpLoading,
          borderRadius: 15,
        );
      },
    ));
  }

  static Widget buildAlreadySignedUpAndLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: AppTextStyles.newToWulflexOrAlreadyHaveAccountText,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => NavigationHelper.navigateToWithReplacement(
              context, const ScreenLogin()),
          child: Text(
            'Login',
            style: AppTextStyles.signUpAndLoginGreenText,
          ),
        ),
      ],
    );
  }
}
