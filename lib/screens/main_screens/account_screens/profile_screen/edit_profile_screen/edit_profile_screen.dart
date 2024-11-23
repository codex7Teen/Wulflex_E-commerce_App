import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/custom_textfields_widget.dart';
import 'package:wulflex/widgets/upload_progress_indicator_widget.dart';

class ScreenEditProfile extends StatefulWidget {
  final String screenTitle;
  final String name;
  final String phoneNumber;
  final String dob;
  const ScreenEditProfile(
      {super.key,
      required this.screenTitle,
      required this.name,
      required this.phoneNumber,
      required this.dob});

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
    _phoneNumberController.text = widget.phoneNumber;
    _dateofbirthController.text = widget.dob;
    
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, "Edit Profile", 0.1),
      body: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            CustomSnackbar.showCustomSnackBar(
                context, 'Profile updated success... 🎉🎉🎉', appearFromTop: true);
            Navigator.pop(context);
          } else if (state is UserProfileError) {
            CustomSnackbar.showCustomSnackBar(
                context, 'Profile updated failed! ⚠️',
                icon: Icons.error, appearFromTop: true);
          }
        },
        child: SingleChildScrollView(
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
                          context.read<UserProfileBloc>().add(PickImageEvent()),
                      child: BlocBuilder<UserProfileBloc, UserProfileState>(
                        builder: (context, state) {
                          File? selectedImage =
                              context.read<UserProfileBloc>().selectedImage;
                          if (state is ImagePickerLoaded) {
                            selectedImage = state.selectedImage;
                          } else if (state is ImageUploadProgress) {
                            selectedImage = state.selectedImage;
                          }
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 140,
                                width: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: selectedImage != null
                                      ? Image.file(selectedImage,
                                          fit: BoxFit.cover)
                                      : Image.asset(
                                          'assets/add_profile.png',
                                          fit: BoxFit.cover,
                                          color: isLightTheme
                                              ? AppColors.blackThemeColor
                                              : AppColors.whiteThemeColor,
                                        ),
                                ),
                              ),
                              if (state is ImageUploadProgress)
                                // show upload progress indicator
                                showUploadProgressIndicator(state)
                            ],
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
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> updates = {};

                        // Add non-empty fields
                        if (_nameController.text.trim().isNotEmpty) {
                          updates['name'] = _nameController.text.trim();
                        }
                        if (_phoneNumberController.text.trim().isNotEmpty) {
                          updates['phoneNumber'] =
                              _phoneNumberController.text.trim();
                        }
                        if (_dateofbirthController.text.trim().isNotEmpty) {
                          updates['dob'] = _dateofbirthController.text.trim();
                        }
                        // Fetch the selected image from the BLoC state
                        final selectedImage = context
                                .read<UserProfileBloc>()
                                .state is ImagePickerLoaded
                            ? (context.read<UserProfileBloc>().state
                                    as ImagePickerLoaded)
                                .selectedImage
                            : null;

                        if (selectedImage != null) {
                          updates['userImage'] = selectedImage.path;
                        } else {
                          log('SELECTED IMAGE IS NULL');
                        }

                        // Dispatch the update event
                        context
                            .read<UserProfileBloc>()
                            .add(UpdateUserProfileEvent(updates));
                      }
                    },
                    child: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        return GreenButtonWidget(
                          isLoading: state is UserProfileLoading ||
                              state is ImageUploadProgress,
                          buttonText: "Save Details",
                          borderRadius: 25,
                          width: 1,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
