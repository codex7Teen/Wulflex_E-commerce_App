import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/widgets/custom_add_address_field_widget.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/cart/presentation/widgets/edit_address_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenEditAddress extends StatefulWidget {
  final String addressId;
  final String name;
  final String phoneNumber;
  final String pincode;
  final String state;
  final String city;
  final String houseName;
  final String areaName;
  ScreenEditAddress(
      {super.key,
      required this.addressId,
      required this.name,
      required this.phoneNumber,
      required this.pincode,
      required this.state,
      required this.city,
      required this.houseName,
      required this.areaName});

  @override
  State<ScreenEditAddress> createState() => _ScreenEditAddressState();
}

class _ScreenEditAddressState extends State<ScreenEditAddress> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _areaNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.text = widget.name;
    _phoneNumberController.text = widget.phoneNumber;
    _pincodeController.text = widget.pincode;
    _stateNameController.text = widget.state;
    _cityNameController.text = widget.city;
    _houseNameController.text = widget.houseName;
    _areaNameController.text = widget.areaName;
    super.initState();
  }

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
      appBar: customAppbarWithBackbutton(context, 'EDIT ADDRESS', 0.115),
      body: SingleChildScrollView(
        child: BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressFailed) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Failed to edit address!',
                  icon: Icons.error);
            } else if (state is AddressSuccess) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Address edited successfully... 🎉🎉🎉');
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
                  EditAddressScreenWidgets.buildNameText(context),
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
                  EditAddressScreenWidgets.buildPhoneNumberText(context),
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
                  EditAddressScreenWidgets.buildPincodeText(context),
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
                  EditAddressScreenWidgets.buildStateAndCityText(context),
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
                  EditAddressScreenWidgets.buildHouseNameText(context),
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
                  EditAddressScreenWidgets.buildAreanameText(context),
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
                      return EditAddressScreenWidgets.buildSaveButton(
                          context,
                          state,
                          _formKey,
                          widget.addressId,
                          _nameController,
                          _phoneNumberController,
                          _pincodeController,
                          _stateNameController,
                          _cityNameController,
                          _houseNameController,
                          _areaNameController);
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
