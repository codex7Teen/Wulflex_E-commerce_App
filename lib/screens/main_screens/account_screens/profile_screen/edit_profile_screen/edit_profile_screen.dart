import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_textfields_widget.dart';

class ScreenEditProfile extends StatefulWidget {
  final String screenTitle;
  final String name;
  const ScreenEditProfile(
      {super.key, required this.screenTitle, required this.name});

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, "Edit Profile", 0.1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upload Image',
                    style: AppTextStyles.editScreenSubHeadings(context)),
                SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        context.read<EditProfileBloc>().add(PickImageEvent()),
                    child: BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                        File? selectedImage;
                        if (state is ImagePickerLoaded) {
                          selectedImage = state.selectedImage;
                        }
                        return SizedBox(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: selectedImage != null
                                ? Image.file(selectedImage, fit: BoxFit.cover)
                                : Image.asset(
                                    'assets/add_profile.png',
                                    fit: BoxFit.cover,
                                    color: isLightTheme
                                        ? AppColors.blackThemeColor
                                        : AppColors.whiteThemeColor,
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text('NAME',
                    style: AppTextStyles.editScreenSubHeadings(context)),
                SizedBox(height: 8),
                CustomTextfieldsWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: _nameController,
                  hintText: 'Please enter your name',
                ),
                SizedBox(height: 25),
                Text('PHONE NUMBER',
                    style: AppTextStyles.editScreenSubHeadings(context)),
                SizedBox(height: 8),
                CustomTextfieldsWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                  textInputType: TextInputType.number,
                  maxCharacterLength: 13,
                  hintText: 'Please enter your number',
                ),
                SizedBox(height: 25),
                Text('DATE OF BIRTH',
                    style: AppTextStyles.editScreenSubHeadings(context)),
                SizedBox(height: 8),
                CustomTextfieldsWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  controller: _dateofbirthController,
                  textInputType: TextInputType.number,
                  maxCharacterLength: 10,
                  hintText: 'Please enter your date of birth',
                ),
                SizedBox(height: 39),
                GestureDetector(
                  onTap: () {
                    formKey.currentState!.validate();
                  },
                  child: GreenButtonWidget(
                    buttonText: "Save Details",
                    borderRadius: 25,
                    width: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
