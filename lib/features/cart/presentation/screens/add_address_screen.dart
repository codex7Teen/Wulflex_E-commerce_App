import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/widgets/custom_add_address_field_widget.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenAddAddress extends StatefulWidget {
  ScreenAddAddress({super.key});

  @override
  State<ScreenAddAddress> createState() => _ScreenAddAddressState();
}

class _ScreenAddAddressState extends State<ScreenAddAddress> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _areaNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _pincodeController.dispose();
    _stateNameController.dispose();
    _cityNameController.dispose();
    _houseNameController.dispose();
    _areaNameController.dispose();
  }

  void _clearAllFields() {
    setState(() {
      // Reset form validation state
      _formKey.currentState?.reset();
      // Clear text controllers
      _nameController.clear();
      _phoneNumberController.clear();
      _pincodeController.clear();
      _stateNameController.clear();
      _cityNameController.clear();
      _houseNameController.clear();
      _areaNameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ADD ADDRESS', 0.115),
      body: SingleChildScrollView(
        child: BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressFailed) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Failed to add address!',
                  icon: Icons.error);
            } else if (state is AddressSuccess) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Address added successfully... 🎉🎉🎉');
              // clears all the fields
              _clearAllFields();
              // Load the address
              context.read<AddressBloc>().add(FetchAddressEvent());
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'NAME',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'PHONE NUMBER',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'PINCODE',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'STATE & CITY',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'HOUSE NO, BUILDING NAME',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'ROAD NAME, AREA, COLONY',
                      style: AppTextStyles.screenSubHeadings(context),
                    ),
                  ),
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
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      return GreenButtonWidget(
                        isLoading: state is AddressLoading,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // do this
                            context.read<AddressBloc>().add(AddAddressEvent(
                                name: _nameController.text.trim(),
                                phoneNumber: _phoneNumberController.text.trim(),
                                pincode: _pincodeController.text.trim(),
                                stateName: _stateNameController.text.trim(),
                                cityName: _cityNameController.text.trim(),
                                houseName: _houseNameController.text.trim(),
                                areaName: _areaNameController.text.trim()));
                          }
                        },
                        buttonText: 'Save Address',
                        borderRadius: 25,
                        width: 1,
                        addIcon: true,
                        icon: Icons.bookmark_outline_rounded,
                      );
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
