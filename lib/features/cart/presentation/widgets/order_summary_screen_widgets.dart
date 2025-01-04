import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/payment_screen.dart';
import 'package:wulflex/features/cart/presentation/screens/select_address_screen.dart';
import 'package:wulflex/features/home/presentation/screens/view_product_details_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class OrderSummaryScreenWidgets {
  static Widget buildAccountInformationContainer(
      BuildContext context, UserModel user) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme(context)
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'ACCOUNT INFORMATION',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              const Column(
                children: [
                  Icon(Icons.person,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2)
                ],
              )
            ],
          ),
          const SizedBox(height: 3),
          Text(
            user.name,
            style: AppTextStyles.screenSubTitles,
          )
        ],
      ),
    );
  }

  static Widget buildDeliveryAddressContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme(context)
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'DELIVERY ADDRESS',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              const Column(
                children: [
                  Icon(Icons.home, color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2)
                ],
              )
            ],
          ),
          const SizedBox(height: 5.5),
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              if (state is AddressLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AddressLoaded) {
                final selectedAddress = state.selectedAddress;
                if (selectedAddress == null) {
                  // Show select address when selectedaddress is null
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 10, bottom: 45),
                    child: GestureDetector(
                      onTap: () {
                        NavigationHelper.navigateToWithoutReplacement(
                            context, const ScreenAddress());
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.greenThemeColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Text('SELECT ADDRESS',
                            style: AppTextStyles.selectAddressText),
                      ),
                    ),
                  );
                }
                // check if selected address values are present
                final selectedAddressContainsValues =
                    selectedAddress.name.trim().isNotEmpty;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 10, bottom: 45),
                      child: GestureDetector(
                        onTap: () {
                          NavigationHelper.navigateToWithoutReplacement(
                              context, const ScreenAddress());
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors.greenThemeColor,
                              borderRadius: BorderRadius.circular(18)),
                          child: Text('SELECT ADDRESS',
                              style: AppTextStyles.selectAddressText),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: selectedAddressContainsValues,
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.1),
                    ),
                    Visibility(
                      visible: selectedAddressContainsValues,
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.greenThemeColor, width: 2)),
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.greenThemeColor),
                        ),
                      ]),
                    ),
                    Visibility(
                        visible: selectedAddressContainsValues,
                        child: const SizedBox(width: 8)),
                    Visibility(
                      visible: selectedAddressContainsValues,
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedAddress.name,
                              style: AppTextStyles.addressListItemsText(context,
                                  fixedBlackColor: true),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "${selectedAddress.houseName}, ${selectedAddress.areaName}",
                              style: AppTextStyles.addressListItemsText(context,
                                  fixedBlackColor: true),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "${selectedAddress.cityName}, ${selectedAddress.stateName}",
                              style: AppTextStyles.addressListItemsText(context,
                                  fixedBlackColor: true),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              selectedAddress.pincode,
                              style: AppTextStyles.addressListItemsText(context,
                                  fixedBlackColor: true),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "Phone: ${selectedAddress.phoneNumber}",
                              style: AppTextStyles.addressListItemsText(context,
                                  fixedBlackColor: true),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return const Center(
                child: Text('something went wrong'),
              );
            },
          )
        ],
      ),
    );
  }

  static Widget buildItemsContainer(
      BuildContext context, List<ProductModel> cartItemsList) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme(context)
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'ITEMS',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              const Column(
                children: [
                  Icon(Icons.shopping_bag_rounded,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 3)
                ],
              )
            ],
          ),
          const SizedBox(height: 4),
          // ITEMS
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cartItemsList.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              final cartItem = cartItemsList[index];
              return GestureDetector(
                onTap: () => NavigationHelper.navigateToWithoutReplacement(
                    context, ScreenViewProducts(productModel: cartItem)),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? AppColors.whiteThemeColor
                          : AppColors.lightGreyThemeColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 84, // Fixed height
                          width: MediaQuery.of(context).size.width * 0.21,
                          child: Image.network(
                            cartItem.imageUrls[0],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/wulflex_logo_nobg.png'),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.sizeOf(context).width *
                                              0.46),
                                  child: Text(
                                    cartItem.brandName,
                                    style: AppTextStyles.itemCardBrandText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      cartItem.selectedSize ??
                                          cartItem.selectedWeight ??
                                          '',
                                      style: AppTextStyles
                                          .selectedSizeOrWeightText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 10)
                                  ],
                                ),
                              ],
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width * 0.46),
                              child: Text(
                                cartItem.name,
                                style: AppTextStyles.itemCardNameText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹${NumberFormat('#,##,###.##').format(cartItem.offerPrice)}",
                                  style: AppTextStyles.itemCardSubTitleText,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text('QTY: ${cartItem.quantity}',
                                      style: AppTextStyles.orderQuantityText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  static Widget buildPricedetailsAndProceedButton(
      BuildContext context,
      double subtotal,
      double discount,
      double total,
      List<ProductModel> cartItemsList,
      AddressModel? selectedAddress) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme(context)
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'PRICE DETAILS',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              const Column(
                children: [
                  Icon(Icons.wallet,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2.5)
                ],
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Subtotal',
                style: AppTextStyles.cartSubtotalAndDiscountText,
              ),
              const Spacer(),
              Text(
                '₹ ${NumberFormat('#,##,###.##').format(subtotal)}',
                style: AppTextStyles.cartSubtotalAndDiscountAmountStyle,
              )
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                'Discount',
                style: AppTextStyles.cartSubtotalAndDiscountText,
              ),
              const Spacer(),
              Text(
                '₹ –${NumberFormat('#,##,###.##').format(discount)}',
                style: AppTextStyles.cartSubtotalAndDiscountAmountStyle,
              )
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                'Delivery Charges',
                style: AppTextStyles.cartSubtotalAndDiscountText,
              ),
              const Spacer(),
              Row(
                children: [
                  Text('₹ 100',
                      style: AppTextStyles.cartSubtotalAndDiscountAmountStyle
                          .copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.greyThemeColor,
                              decorationThickness: 2)),
                  Text(
                    ' FREE Delivery',
                    style: AppTextStyles.cartSubtotalAndDiscountAmountStyle,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 3),
          const Divider(color: AppColors.hardLightGeryThemeColor, thickness: 0.3),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                'Total Amount',
                style: AppTextStyles.cartTotalText,
              ),
              const Spacer(),
              Text(
                '₹ ${NumberFormat('#,##,###.##').format(total)}',
                style: AppTextStyles.cartTotalAmountText,
              )
            ],
          ),
          const SizedBox(height: 14),
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              bool selectedAddressContainsValues = false;
              if (selectedAddress != null) {
                selectedAddressContainsValues =
                    selectedAddress.name.trim().isNotEmpty;
              }
              log('SELECTED ADDRESS HAS VALUE: $selectedAddressContainsValues');

              return GreenButtonWidget(
                  onTap: () {
                    if (selectedAddressContainsValues &&
                        selectedAddress != null) {
                      log('Selected address has value. So proceeding to payment...');
                      NavigationHelper.navigateToWithoutReplacement(
                          context,
                          ScreenPayment(
                            totalAmount: total,
                            cartProducts: cartItemsList,
                            selectedAddress: selectedAddress,
                          ));
                    } else {
                      CustomSnackbar.showCustomSnackBar(
                          context, 'Please select an address to proceed!',
                          icon: Icons.error);
                    }
                  },
                  addIcon: true,
                  icon: Icons.check_circle_outline_rounded,
                  buttonText: 'Proceed to Payment',
                  borderRadius: 25,
                  width: 1);
            },
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
