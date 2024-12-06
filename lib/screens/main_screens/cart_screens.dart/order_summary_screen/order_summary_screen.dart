import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/address_bloc/address_bloc.dart';
import 'package:wulflex/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/screens/main_screens/cart_screens.dart/address_screens/address_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenOrderSummary extends StatelessWidget {
  const ScreenOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger FetchUserProfileEvent and fetch address event when the screen is built
    context.read<UserProfileBloc>().add(FetchUserProfileEvent());
    context.read<AddressBloc>().add(FetchAddressEvent());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ORDER SUMMARY', 0.06),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileError) {
            // display error
          } else if (state is UserProfileLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.only(
                  top: 25, left: 18, right: 18, bottom: 18),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                              style: AppTextStyles.screenSubHeadings(context),
                            ),
                            SizedBox(width: 6),
                            Column(
                              children: [
                                Icon(Icons.person,
                                    color: AppColors.blackThemeColor, size: 22),
                                SizedBox(height: 2)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          user.name,
                          style: AppTextStyles.screenSubTitles,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                              style: AppTextStyles.screenSubHeadings(context),
                            ),
                            SizedBox(width: 6),
                            Column(
                              children: [
                                Icon(Icons.home,
                                    color: AppColors.blackThemeColor, size: 22),
                                SizedBox(height: 2)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 4),
                        BlocBuilder<AddressBloc, AddressState>(
                          builder: (context, state) {
                            if (state is AddressLoading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is AddressLoaded) {
                              final selectedAddress = state.selectedAddress;
                              if (selectedAddress != null) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        NavigationHelper
                                            .navigateToWithoutReplacement(
                                                context, ScreenAddress());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: AppColors.greenThemeColor,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: Text('SELECT',
                                            style: AppTextStyles
                                                .selectAddressText),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.2),
                                    Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColors
                                                        .greenThemeColor,
                                                    width: 2)),
                                          ),
                                          Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color:
                                                    AppColors.greenThemeColor),
                                          ),
                                        ]),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedAddress.name,
                                            style: AppTextStyles
                                                .addressListItemsText,
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${selectedAddress.houseName}, ${selectedAddress.areaName}",
                                            style: AppTextStyles
                                                .addressListItemsText,
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${selectedAddress.cityName}, ${selectedAddress.stateName}",
                                            style: AppTextStyles
                                                .addressListItemsText,
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            selectedAddress.pincode,
                                            style: AppTextStyles
                                                .addressListItemsText,
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            "Phone: ${selectedAddress.phoneNumber}",
                                            style: AppTextStyles
                                                .addressListItemsText,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    NavigationHelper
                                        .navigateToWithoutReplacement(
                                            context, ScreenAddress());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: AppColors.greenThemeColor,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Text('SELECT',
                                        style: AppTextStyles.selectAddressText),
                                  ),
                                );
                              }
                            }
                            return Center(
                              child: Text('something went wrong'),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Some Unknown error have occured.'));
        },
      ),
    );
  }
}
