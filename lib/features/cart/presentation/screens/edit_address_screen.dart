import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
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
  const ScreenEditAddress(
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
                  EditAddressScreenWidgets.buildNameField(_nameController),
                  const SizedBox(height: 16),
                  EditAddressScreenWidgets.buildPhoneNumberText(context),
                  EditAddressScreenWidgets.buildPhoneNumberField(
                      _phoneNumberController),
                  const SizedBox(height: 16),
                  EditAddressScreenWidgets.buildPincodeText(context),
                  EditAddressScreenWidgets.buildPincodeField(
                      _pincodeController, context),
                  const SizedBox(height: 16),
                  EditAddressScreenWidgets.buildStateAndCityText(context),
                  EditAddressScreenWidgets.buildStateandCityField(
                      _stateNameController, _cityNameController, context),
                  const SizedBox(height: 16),
                  EditAddressScreenWidgets.buildHouseNameText(context),
                  EditAddressScreenWidgets.buildHouseNameField(
                      _houseNameController),
                  const SizedBox(height: 16),
                  EditAddressScreenWidgets.buildAreanameText(context),
                  EditAddressScreenWidgets.buildAreanameField(
                      _areaNameController),
                  const SizedBox(height: 25),
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
