import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/add_address_screen.dart';
import 'package:wulflex/features/cart/presentation/screens/edit_address_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

Widget buildaddNewAddressButton(BuildContext context) {
  return GreenButtonWidget(
      onTap: () {
        NavigationHelper.navigateToWithoutReplacement(
            context, ScreenAddAddress());
      },
      width: 1,
      buttonText: 'Add a new address',
      borderRadius: 25,
      icon: Icons.add,
      addIcon: true);
}

Widget buildManageAddressText(BuildContext context) {
  return Text(
    'MANGE ADDRESS',
    style: AppTextStyles.screenSubHeadings(context),
  );
}

Widget buildAddressCard(List<AddressModel> addressList) {
  return Expanded(
    child: ListView.separated(
      itemCount: addressList.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 14);
      },
      itemBuilder: (context, index) {
        final address = addressList[index];
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.greyThemeColor, width: 0.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 0) {
                    // Handle Edit action
                    log('${address.id} EDIT ATTEMPTED');
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
                          areaName: address.areaName,
                        ));
                  } else if (value == 1) {
                    log('${address.id} DELETE ATTEMPTED');
                    // Handle Delete action
                    context
                        .read<AddressBloc>()
                        .add(DeleteAddressEvent(addressId: address.id!));
                  }
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.darkishGrey,
                  size: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: AppColors.darkishGrey),
                        SizedBox(width: 8),
                        Text(
                          'Edit',
                          style: GoogleFonts.robotoCondensed(
                            color: AppColors.blackThemeColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Delete',
                          style: GoogleFonts.robotoCondensed(
                            color: AppColors.blackThemeColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ),
  );
}
