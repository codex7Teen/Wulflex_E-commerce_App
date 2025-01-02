import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/account/presentation/widgets/custom_date_picker_widget.dart';
import 'package:wulflex/features/account/presentation/widgets/edit_profile_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/custom_textfields_widget.dart';

class ScreenEditProfile extends StatefulWidget {
  final String screenTitle;
  final String name;
  final String phoneNumber;
  final String dob;
  final String networkImageUrl;
  const ScreenEditProfile(
      {super.key,
      required this.screenTitle,
      required this.name,
      required this.phoneNumber,
      required this.dob,
      required this.networkImageUrl});

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
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _dateofbirthController.dispose();
    super.dispose();

    // Move the BLoC event to didChangeDependencies or initState
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add reset event when dependencies change
    context.read<UserProfileBloc>().add(ResetProfileStateEvent());
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
                context, 'Profile updated success... 🎉🎉🎉',
                appearFromTop: true);
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
                  EditProfileScreenWidgets.buildUploadImageText(context),
                  SizedBox(height: 15),
                  EditProfileScreenWidgets.buildUploadImageIcon(
                      context, widget.networkImageUrl),
                  SizedBox(height: 25),
                  EditProfileScreenWidgets.buildNameText(context),
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
                  EditProfileScreenWidgets.buildPhoneNumberText(context),
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
                  EditProfileScreenWidgets.buildDateofbirthText(context),
                  SizedBox(height: 8),
                  CustomDatePickerField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                    controller: _dateofbirthController,
                    hintText: 'Select your date of birth',
                  ),
                  SizedBox(height: 39),
                  BlocBuilder<UserProfileBloc, UserProfileState>(
                    builder: (context, state) {
                      return EditProfileScreenWidgets.buildSaveButton(
                          context,
                          formKey,
                          _nameController,
                          _phoneNumberController,
                          _dateofbirthController,
                          state);
                    },
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
