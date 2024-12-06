import 'package:flutter/material.dart';
import 'package:wulflex/screens/main_screens/cart_screens.dart/address_screens/widgets/custom_add_address_field_widget.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';

class ScreenAddAddress extends StatelessWidget {
  ScreenAddAddress({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _areaNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbarWithBackbutton(context, 'ADD ADDRESS', 0.115),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAddAddressFieldWidget(
                    hintText: 'Full Name (Required)*',
                    textInputType: TextInputType.text,
                    maxLength: 16,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: _nameController),
                SizedBox(height: 16),
                CustomAddAddressFieldWidget(
                    hintText: 'Phone number (Required)*',
                    textInputType: TextInputType.number,
                    maxLength: 12,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter contact number';
                      }
                      return null;
                    },
                    controller: _phoneNumberController),
                SizedBox(height: 16),
                CustomAddAddressFieldWidget(
                    textFieldWidth: MediaQuery.sizeOf(context).width * 0.5,
                    hintText: 'Pincode (Required)*',
                    textInputType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your area pincode';
                      }
                      return null;
                    },
                    controller: _pincodeController),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomAddAddressFieldWidget(
                          textFieldWidth:
                              MediaQuery.sizeOf(context).width * 0.5,
                          hintText: 'State (Required)*',
                          textInputType: TextInputType.text,
                          maxLength: 14,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your state';
                            }
                            return null;
                          },
                          controller: _stateNameController),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: CustomAddAddressFieldWidget(
                          textFieldWidth:
                              MediaQuery.sizeOf(context).width * 0.5,
                          hintText: 'City (Required)*',
                          textInputType: TextInputType.text,
                          maxLength: 14,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          controller: _cityNameController),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CustomAddAddressFieldWidget(
                    hintText: 'House No, Building name (Required)*',
                    textInputType: TextInputType.text,
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your building details';
                      }
                      return null;
                    },
                    controller: _houseNameController),
                SizedBox(height: 16),
                CustomAddAddressFieldWidget(
                    hintText: 'Road name, Area, Colony (Required)*',
                    textInputType: TextInputType.text,
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your area details';
                      }
                      return null;
                    },
                    controller: _areaNameController),
                SizedBox(height: 25),
                GreenButtonWidget(
                  onTap: () {
                    _formKey.currentState!.validate();
                  },
                  buttonText: 'Save Address',
                  borderRadius: 25,
                  width: 1,
                  addIcon: true,
                  icon: Icons.bookmark_outline_rounded,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
