import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/address_bloc/address_bloc.dart';
import 'package:wulflex/screens/main_screens/cart_screens.dart/address_screens/add_address_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenAddress extends StatelessWidget {
  const ScreenAddress({super.key});

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
              'SELECT ADDRESS',
              style: AppTextStyles.screenSubHeadings(context),
            ),
            SizedBox(height: 10),
            BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddressLoaded) {
                  final addressList = state.address;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: addressList.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 14);
                      },
                      itemBuilder: (context, index) {
                        final address = addressList[index];
                        return Container(
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  color: AppColors.greyThemeColor, width: 0.5)),
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
                                          color: AppColors.greyThemeColor,
                                          width: 2)),
                                ),
                                Container(
                                  height: 14,
                                  width: 14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.greenThemeColor),
                                ),
                              ]),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.name,
                                    style: AppTextStyles.addressNameText,
                                  ),
                                  SizedBox(height: 10),
                                  Text(address.houseName,
                                      style:
                                          AppTextStyles.addressListItemsText),
                                  Text(
                                      "${address.areaName}, ${address.cityName}",
                                      style:
                                          AppTextStyles.addressListItemsText),
                                  Text(
                                      "${address.stateName}, ${address.pincode}",
                                      style:
                                          AppTextStyles.addressListItemsText),
                                  SizedBox(height: 10),
                                  Text(address.phoneNumber,
                                      style:
                                          AppTextStyles.addressListItemsText),
                                ],
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 4),
                                decoration: BoxDecoration(
                                    color: AppColors.greenThemeColor,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Text('EDIT',
                                    style: AppTextStyles.selectAddressText),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: Text('Something went wrong'));
              },
            )
          ],
        ),
      ),
    );
  }
}
