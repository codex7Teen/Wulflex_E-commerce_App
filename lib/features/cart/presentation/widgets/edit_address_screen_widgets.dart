import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/widgets/custom_add_address_field_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';

class EditAddressScreenWidgets {
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

  static Widget buildStateAndCityText(BuildContext context) {
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

  static Widget buildAreanameText(BuildContext context) {
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
      AddressState state,
      GlobalKey<FormState> formKey,
      String addressId,
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
          context.read<AddressBloc>().add(EditAddressEvent(
              addressId: addressId,
              name: nameController.text.trim(),
              phoneNumber: phoneNumberController.text.trim(),
              pincode: pincodeController.text.trim(),
              stateName: stateNameController.text.trim(),
              cityName: cityNameController.text.trim(),
              houseName: houseNameController.text.trim(),
              areaName: areaNameController.text.trim()));
        }
      },
      buttonText: 'Update Address',
      borderRadius: 25,
      width: 1,
      addIcon: true,
      icon: Icons.check,
    );
  }

  static Widget buildNameField(TextEditingController nameController) {
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

  static Widget buildPhoneNumberField(
      TextEditingController phoneNumberController) {
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

  static Widget buildPincodeField(
      TextEditingController pincodeController, BuildContext context) {
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

  static Widget buildStateandCityField(
      TextEditingController stateNameController,
      TextEditingController cityNameController,
      BuildContext context) {
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

  static Widget buildHouseNameField(TextEditingController houseNameController) {
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

  static Widget buildAreanameField(TextEditingController areaNameController) {
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
