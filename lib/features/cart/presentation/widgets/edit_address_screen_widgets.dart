import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
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
}
