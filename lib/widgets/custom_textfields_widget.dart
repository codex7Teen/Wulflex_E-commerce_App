import 'package:flutter/material.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';

class CustomTextfieldsWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final int? maxCharacterLength;
  final String? hintText;
  const CustomTextfieldsWidget(
      {super.key,
      this.textInputType = TextInputType.text,
      this.minLines = 1,
      this.maxLines = 1,
      this.validator,
      required this.controller,
      this.maxCharacterLength = 16,
      this.hintText = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightGreyThemeColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 0),
        child: TextFormField(
          maxLength: maxCharacterLength,
          autovalidateMode: AutovalidateMode.onUnfocus,
          controller: controller,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: textInputType,
          style: AppTextStyles.editScreenTextfieldStyles(context),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.editScreenHinttextStyles(context)),
        ),
      ),
    );
  }
}
