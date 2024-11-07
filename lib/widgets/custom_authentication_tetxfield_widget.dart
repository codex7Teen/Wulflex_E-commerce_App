import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class CustomAuthenticationTetxfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final VoidCallback? toggleVisibility;
  final bool isPasswordVisible;
  const CustomAuthenticationTetxfieldWidget({super.key, required this.controller, required this.hintText, required this.icon, this.obscureText = false, this.validator, this.toggleVisibility, this.isPasswordVisible = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Icon(
            icon,
            color: AppColors.greyThemeColor,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            style: AppTextStyles.authenticationTextfieldStyle,
            controller: controller,
            obscureText: obscureText && !isPasswordVisible,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:AppTextStyles.authenticationHintTextStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyThemeColor,
                  width: 0.4,
                ),
              ),
              suffixIcon: toggleVisibility != null
                  ? GestureDetector(
                      onTap: toggleVisibility,
                      child: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off_sharp
                            : Icons.visibility,
                        color: AppColors.greyThemeColor,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}