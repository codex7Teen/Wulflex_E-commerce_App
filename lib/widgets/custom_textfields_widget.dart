import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class CustomTextfieldsWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  const CustomTextfieldsWidget(
      {super.key,
      this.textInputType = TextInputType.text,
      this.minLines = 1,
      this.maxLines = 1,
      this.validator,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightGreyThemeColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 2),
        child: TextFormField(
          maxLength: 16,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: textInputType,
          style: AppTextStyles.authenticationTextfieldStyle,
          //TODO ADD A HINTTEXT FOR EACH FIELDS
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
