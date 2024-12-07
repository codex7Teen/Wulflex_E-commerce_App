import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wulflex/blocs/address_bloc/address_bloc.dart';
import 'package:wulflex/screens/main_screens/cart_screens.dart/address_screens/add_address_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenManageAddress extends StatelessWidget {
  const ScreenManageAddress({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddressBloc>().add(FetchAddressEvent());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ADDRESS'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
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
            ),
            SizedBox(height: 20),
            Text(
              'MANGE ADDRESS',
              style: AppTextStyles.screenSubHeadings(context),
            ),
            SizedBox(height: 10),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddressLoaded) {
                  final addressList = state.address;
                  // Show addresses only if addlist is not empty and show a lottie while empty
                  if (addressList.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: addressList.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 14);
                        },
                        itemBuilder: (context, index) {
                          final address = addressList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: AppColors.greyThemeColor,
                                    width: 0.5)),
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
                                        style:
                                            AppTextStyles.addressListItemsText(context)),
                                    Text(
                                        "${address.areaName}, ${address.cityName}",
                                        style:
                                            AppTextStyles.addressListItemsText(context)),
                                    Text(
                                        "${address.stateName}, ${address.pincode}",
                                        style:
                                            AppTextStyles.addressListItemsText(context)),
                                    SizedBox(height: 10),
                                    Text("Phone: ${address.phoneNumber}",
                                        style:
                                            AppTextStyles.addressListItemsText(context)),
                                  ],
                                ),
                                Spacer(),
                                PopupMenuButton<int>(
                                  onSelected: (value) {
                                    if (value == 0) {
                                      // Handle Edit action
                                    } else if (value == 1) {
                                      log('${address.id} DELETE ATTEMPTED');
                                      // Handle Delete action
                                      context.read<AddressBloc>().add(
                                          DeleteAddressEvent(
                                              addressId: address.id!));
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
                                          Icon(Icons.edit,
                                              color: AppColors.darkishGrey),
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
                  } else {
                    return Center(
                        child:
                            Text('Address is empty : TODO SHOW A LOTTIE HERE'));
                  }
                }
                return Center(child: Text('Something went wrong'));
              },
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
