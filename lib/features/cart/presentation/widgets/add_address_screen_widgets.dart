import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/widgets/custom_add_address_field_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';

class AddAddressScreenWidgets {
  static Widget buildNameText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'NAME',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildPhoneNumberText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'PHONE NUMBER',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildPincodeText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'PINCODE',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildStateandcityText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'STATE & CITY',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildHouseNameText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'HOUSE NO, BUILDING NAME',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildAreaNameText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'ROAD NAME, AREA, COLONY',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildSaveButton(
      BuildContext context,
      GlobalKey<FormState> formKey,
      AddressState state,
      TextEditingController nameController,
      TextEditingController phoneNumberController,
      TextEditingController pincodeController,
      TextEditingController stateNameController,
      TextEditingController cityNameController,
      TextEditingController houseNameController,
      TextEditingController areaNameController) {
    return GreenButtonWidget(
      isLoading: state is AddressLoading,
      onTap: () async {
        if (formKey.currentState!.validate()) {
          // do this
          context.read<AddressBloc>().add(AddAddressEvent(
              name: nameController.text.trim(),
              phoneNumber: phoneNumberController.text.trim(),
              pincode: pincodeController.text.trim(),
              stateName: stateNameController.text.trim(),
              cityName: cityNameController.text.trim(),
              houseName: houseNameController.text.trim(),
              areaName: areaNameController.text.trim()));
        }
      },
      buttonText: 'Save Address',
      borderRadius: 25,
      width: 1,
      addIcon: true,
      icon: Icons.bookmark_outline_rounded,
    );
  }

  static Widget buildNameTextfield(
      BuildContext context, TextEditingController nameController) {
    return CustomAddAddressFieldWidget(
        hintText: 'Full Name (Required)*',
        textInputType: TextInputType.text,
        maxLength: 16,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        controller: nameController);
  }

  static Widget buildPhoneNumberTextfield(
      BuildContext context, TextEditingController phoneNumberController) {
    return CustomAddAddressFieldWidget(
        hintText: 'Phone number (Required)*',
        textInputType: TextInputType.number,
        maxLength: 12,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter contact number';
          }
          return null;
        },
        controller: phoneNumberController);
  }

  static Widget buildPincodeTextfield(
      BuildContext context, TextEditingController pincodeController) {
    return CustomAddAddressFieldWidget(
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
        controller: pincodeController);
  }

  static Widget buildStateAndCityTextfield(
      BuildContext context,
      TextEditingController stateNameController,
      TextEditingController cityNameController) {
    return Row(
      children: [
        Expanded(
          child: CustomAddAddressFieldWidget(
              textFieldWidth: MediaQuery.sizeOf(context).width * 0.5,
              hintText: 'State (Required)*',
              textInputType: TextInputType.text,
              maxLength: 14,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your state';
                }
                return null;
              },
              controller: stateNameController),
        ),
        SizedBox(width: 15),
        Expanded(
          child: CustomAddAddressFieldWidget(
              textFieldWidth: MediaQuery.sizeOf(context).width * 0.5,
              hintText: 'City (Required)*',
              textInputType: TextInputType.text,
              maxLength: 14,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
              controller: cityNameController),
        ),
      ],
    );
  }

  static Widget buildHouseNameTextfield(
      BuildContext context, TextEditingController houseNameController) {
    return CustomAddAddressFieldWidget(
        hintText: 'House No, Building name (Required)*',
        textInputType: TextInputType.text,
        maxLength: 30,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your building details';
          }
          return null;
        },
        controller: houseNameController);
  }

  static Widget buildAreaNameTextfield(
      BuildContext context, TextEditingController areaNameController) {
    return CustomAddAddressFieldWidget(
        hintText: 'Road name, Area, Colony (Required)*',
        textInputType: TextInputType.text,
        maxLength: 30,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your area details';
          }
          return null;
        },
        controller: areaNameController);
  }
}
