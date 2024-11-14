import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_authentication_tetxfield_widget.dart';
import 'package:wulflex/widgets/custom_textfields_widget.dart';

class ScreenEditProfile extends StatefulWidget {
  final String screenTitle;
  const ScreenEditProfile({super.key, required this.screenTitle});

  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Track selected weights
  Set<String> selectedWeights = {};

  // List to store picked image path
  List<String> selectedImages = [];

  // Checkbox State
  bool isAgreed = false;

  Future pickImage() async {
    // Open image picker
    final ImagePicker picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: AppTextStyles.screenSubHeadings(context)),
                SizedBox(height: 25),
                Text('NAME',
                    style: AppTextStyles.screenSubHeadings(context)),
                SizedBox(height: 8),
                CustomTextfieldsWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: _nameController,
                ),
                SizedBox(height: 25),
                Text('PHONE NUMBER',
                    style: AppTextStyles.screenSubHeadings(context)),
                SizedBox(height: 8),
                CustomTextfieldsWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                ),
                SizedBox(height: 25),
                //TODO CREATE A DATE PICKER
              ],
            ),
          ),
        ),
      ),
    );
  }
}
