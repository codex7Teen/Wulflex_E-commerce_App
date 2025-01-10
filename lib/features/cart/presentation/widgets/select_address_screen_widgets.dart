import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/add_address_screen.dart';
import 'package:wulflex/features/cart/presentation/screens/edit_address_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class SelectAddressScreenWidgets {
  static Widget buildAddAddressButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.navigateToWithoutReplacement(
            context, const ScreenAddAddress());
      },
      child: const GreenButtonWidget(
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
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final address = addressList[index];
          final isSelected = state.selectedAddress != null &&
              state.selectedAddress!.id == address.id;
          return GestureDetector(
            onTap: () {
              context
                  .read<AddressBloc>()
                  .add(SelectAddressEvent(address: address));
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.greenThemeColor
                          : AppColors.greyThemeColor,
                      width: isSelected ? 2 : 0.5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
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
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Address details column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.name,
                                style: AppTextStyles.addressNameText(context),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                address.houseName,
                                style:
                                    AppTextStyles.addressListItemsText(context),
                              ),
                              Text(
                                "${address.areaName}, ${address.cityName}",
                                style:
                                    AppTextStyles.addressListItemsText(context),
                              ),
                              Text(
                                "${address.stateName}, ${address.pincode}",
                                style:
                                    AppTextStyles.addressListItemsText(context),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Phone: ${address.phoneNumber}",
                                style:
                                    AppTextStyles.addressListItemsText(context),
                              ),
                            ],
                          ),
                        ),
                        // Edit button
                        const SizedBox(width: 8),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.greenThemeColor,
                                borderRadius: BorderRadius.circular(18)),
                            child: Text('EDIT',
                                style: AppTextStyles.selectAddressText),
                          ),
                        ),
                      ],
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

  static Widget buildEmptyAddressDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 90),
          isLightTheme(context)
              ? Lottie.asset('assets/lottie/empty_address_black.json',
                  width: 190, repeat: true)
              : Lottie.asset('assets/lottie/empty_address_white.json',
                  width: 190, repeat: true),
          Text(
            'No address added yet.\nAdd one to proceed! ',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyScreenText(context),
          ),
          const SizedBox(height: 90)
        ],
      ),
    );
  }

  static Widget buildSelectAddressShimmer() {
    return Expanded(
      child: ListView.separated(
        itemCount: 4, // Show 3 shimmer cards
        separatorBuilder: (context, index) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor:
                isLightTheme(context) ? Colors.grey[300]! : Colors.grey[800]!,
            highlightColor:
                isLightTheme(context) ? Colors.grey[100]! : Colors.grey[700]!,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.greyThemeColor, width: 0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name shimmer
                      Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // House name shimmer
                      Container(
                        width: 200,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Area and city shimmer
                      Container(
                        width: 180,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // State and pincode shimmer
                      Container(
                        width: 160,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Phone number shimmer
                      Container(
                        width: 140,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Menu icon shimmer
                  Container(
                    width: 44,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
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
