import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen/login_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';

Widget buildSignUpImage(BuildContext context) {
  return Center(
    child: Image.asset('assets/signup_illustric.png',
        width: MediaQuery.sizeOf(context).width * 0.645),
  );
}

Widget buildSignUpText() {
  return Text('SIGN UP',
      style: AppTextStyles.headLineLarge.copyWith(color: Colors.black));
}

Widget buildNameTextField(TextEditingController nameTextController) {
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

Widget buildEmaiTextField(TextEditingController emailController) {
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

Widget buildCreatePasswordTextField(
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

Widget buildConfirmPasswordTextField(
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

Widget buildTermsAndConditonsText() {
  return Row(
    children: [
      Text(
        "By signing up, you're agreeing to our",
        style: AppTextStyles.titleXSmallThin,
      ),
      SizedBox(width: 5),
      Text("Terms & Conditions",
          style: AppTextStyles.titleXSmall
              .copyWith(color: AppColors.greenThemeColor)),
    ],
  );
}

Widget buildPrivacyPolicyText() {
  return Row(
    children: [
      Text(
        "and",
        style: AppTextStyles.titleXSmallThin,
      ),
      SizedBox(width: 5),
      Text(
        "Privacy Policy",
        style: AppTextStyles.titleXSmall
            .copyWith(color: AppColors.greenThemeColor),
      ),
    ],
  );
}

Widget buildSignUpButton(
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
      );
    },
  ));
}

Widget buildAlreadySignedUpAndLoginText(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Already have an account?',
        style: AppTextStyles.titleSmall,
      ),
      SizedBox(width: 5),
      GestureDetector(
        onTap: () =>
            NavigationHelper.navigateToWithReplacement(context, ScreenLogin()),
        child: Text(
          'Login',
          style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.greenThemeColor, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
