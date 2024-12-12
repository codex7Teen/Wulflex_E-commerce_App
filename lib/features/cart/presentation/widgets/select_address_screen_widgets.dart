import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/add_address_screen.dart';
import 'package:wulflex/features/cart/presentation/screens/edit_address_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class SelectAddressScreenWidgets {
  static Widget buildAddAddressButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.navigateToWithoutReplacement(
            context, ScreenAddAddress());
      },
      child: GreenButtonWidget(
          width: 1,
          buttonText: 'Add a new address',
          borderRadius: 25,
          icon: Icons.add,
          addIcon: true),
    );
  }

  static Widget buildSelectAddressText(BuildContext context) {
    return Text(
      'SELECT ADDRESS',
      style: AppTextStyles.screenSubHeadings(context),
    );
  }

  static Widget buildAddressSelectionCard(
      List<AddressModel> addressList, AddressLoaded state) {
    return Expanded(
      child: ListView.separated(
        itemCount: addressList.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final address = addressList[index];
          // Check if this address is the selected one
          final isSelected = state.selectedAddress != null &&
              state.selectedAddress!.id == address.id;
          return GestureDetector(
            onTap: () {
              // Select the address
              context
                  .read<AddressBloc>()
                  .add(SelectAddressEvent(address: address));
            },
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.greenThemeColor
                          : AppColors.greyThemeColor,
                      width: isSelected ? 2 : 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: isSelected
                                  ? AppColors.greenThemeColor
                                  : AppColors.greyThemeColor,
                              width: 2)),
                    ),
                    Visibility(
                      visible: isSelected,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.greenThemeColor),
                      ),
                    ),
                  ]),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: AppTextStyles.addressNameText(context),
                      ),
                      SizedBox(height: 10),
                      Text(address.houseName,
                          style: AppTextStyles.addressListItemsText(context)),
                      Text("${address.areaName}, ${address.cityName}",
                          style: AppTextStyles.addressListItemsText(context)),
                      Text("${address.stateName}, ${address.pincode}",
                          style: AppTextStyles.addressListItemsText(context)),
                      SizedBox(height: 10),
                      Text("Phone: ${address.phoneNumber}",
                          style: AppTextStyles.addressListItemsText(context)),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      NavigationHelper.navigateToWithoutReplacement(
                          context,
                          ScreenEditAddress(
                              addressId: address.id!,
                              name: address.name,
                              phoneNumber: address.phoneNumber,
                              pincode: address.pincode,
                              state: address.stateName,
                              city: address.cityName,
                              houseName: address.houseName,
                              areaName: address.areaName));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.greenThemeColor,
                          borderRadius: BorderRadius.circular(18)),
                      child:
                          Text('EDIT', style: AppTextStyles.selectAddressText),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
