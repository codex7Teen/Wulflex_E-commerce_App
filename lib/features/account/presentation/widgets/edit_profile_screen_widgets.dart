import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';
import 'package:wulflex/shared/widgets/upload_progress_indicator_widget.dart';

class EditProfileScreenWidgets {
  static Widget buildUploadImageText(BuildContext context) {
    return Text('Upload Image',
        style: AppTextStyles.editScreenSubHeadings(context));
  }

  static Widget buildUploadImageIcon(
      BuildContext context, String networkImageUrl) {
    return Center(
      child: GestureDetector(
        onTap: () => context.read<UserProfileBloc>().add(PickImageEvent()),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            File? selectedImage = context.read<UserProfileBloc>().selectedImage;
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
                        ? Image.file(selectedImage, fit: BoxFit.cover)
                        : networkImageUrl.isNotEmpty
                            ? Image.network(networkImageUrl, fit: BoxFit.cover)
                            : Image.asset(
                                'assets/add_profile.png',
                                fit: BoxFit.cover,
                                color: isLightTheme(context)
                                    ? AppColors.blackThemeColor
                                    : AppColors.whiteThemeColor,
                              ),
                  ),
                ),
                if (state is ImageUploadProgress)
                  showUploadProgressIndicator(state),
                // Add edit icon overlay
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static Widget buildNameText(BuildContext context) {
    return Text('NAME', style: AppTextStyles.editScreenSubHeadings(context));
  }

  static Widget buildPhoneNumberText(BuildContext context) {
    return Text('PHONE NUMBER',
        style: AppTextStyles.editScreenSubHeadings(context));
  }

  static Widget buildDateofbirthText(
    BuildContext context,
  ) {
    return Text('DATE OF BIRTH',
        style: AppTextStyles.editScreenSubHeadings(context));
  }

  static Widget buildSaveButton(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController nameController,
      TextEditingController phoneNumberController,
      TextEditingController dateofbirthController,
      UserProfileState state) {
    return GreenButtonWidget(
      onTap: () {
        if (formKey.currentState!.validate()) {
          Map<String, dynamic> updates = {};

          // Add non-empty fields
          if (nameController.text.trim().isNotEmpty) {
            updates['name'] = nameController.text.trim();
          }
          if (phoneNumberController.text.trim().isNotEmpty) {
            updates['phoneNumber'] = phoneNumberController.text.trim();
          }
          if (dateofbirthController.text.trim().isNotEmpty) {
            updates['dob'] = dateofbirthController.text.trim();
          }
          // Fetch the selected image from the BLoC state
          final selectedImage =
              context.read<UserProfileBloc>().state is ImagePickerLoaded
                  ? (context.read<UserProfileBloc>().state as ImagePickerLoaded)
                      .selectedImage
                  : null;

          if (selectedImage != null) {
            updates['userImage'] = selectedImage.path;
          } else {
            log('SELECTED IMAGE IS NULL');
          }

          // Dispatch the update event
          context.read<UserProfileBloc>().add(UpdateUserProfileEvent(updates));
        }
      },
      icon: Icons.bookmark,
      addIcon: true,
      isLoading: state is UserProfileLoading || state is ImageUploadProgress,
      buttonText: "Save Details",
      borderRadius: 25,
      width: 1,
    );
  }
}
