import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

// ignore: must_be_immutable
class CustomAddAddressFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final double? textFieldWidth;
  void Function(String)? onChanged;
  FocusNode? focusNode;
  CustomAddAddressFieldWidget(
      {super.key,
      this.hintText,
      this.textInputType = TextInputType.text,
      this.maxLength,
      this.validator,
      this.textFieldWidth,
      required this.controller,
      this.onChanged,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: textFieldWidth,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.greyThemeColor, width: 0.8),
      ),
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: textInputType,
        validator: validator,
        controller: controller,
        maxLength: maxLength,
        style: AppTextStyles.addressScreenTextfieldStyles(context),
        decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyles.addressScreenTextfieldHintStyles(context)),
      ),
    );
  }
}
