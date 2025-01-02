import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

class CustomDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const CustomDatePickerField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.text.isEmpty 
          ? DateTime.now() 
          : DateFormat('dd/MM/yyyy').parse(controller.text),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

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
          controller: controller,
          validator: validator,
          readOnly: true,
          onTap: () => _selectDate(context),
          style: AppTextStyles.editScreenTextfieldStyles(context),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyles.editScreenHinttextStyles(context),
            suffixIcon: Icon(Icons.calendar_today, size: 20),
          ),
        ),
      ),
    );
  }
}