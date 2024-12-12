import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/cart/bloc/payment_bloc/payment_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/order_success_screen.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenPayment extends StatelessWidget {
  final double totalAmount;
  const ScreenPayment({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, "Payment"),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 24),
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
                            'TOTAL AMOUNT',
                            style: AppTextStyles.screenSubHeadings(context,
                                fixedBlackColor: true),
                          ),
                          SizedBox(width: 6),
                          Column(
                            children: [
                              Icon(Icons.wallet,
                                  color: AppColors.blackThemeColor, size: 22),
                              SizedBox(height: 2)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        '₹ ${totalAmount.toString()}',
                        style: AppTextStyles.paymentPageTotalAmountText,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 18),
                //! PAYMENT OPTIONS
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
                            'PAYMENT OPTIONS',
                            style: AppTextStyles.screenSubHeadings(context,
                                fixedBlackColor: true),
                          ),
                          SizedBox(width: 6),
                          Column(
                            children: [
                              Icon(Icons.wallet,
                                  color: AppColors.blackThemeColor, size: 22),
                              SizedBox(height: 2)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 3),
                      //! cash on delvry
                      GestureDetector(
                        onTap: () {
                          context
                              .read<PaymentBloc>()
                              .add(SelectCashOnDeliveryEvent());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 11, horizontal: 14),
                          decoration: BoxDecoration(
                            color: isLightTheme(context)
                                ? AppColors.whiteThemeColor
                                : AppColors.lightGreyThemeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: state.isCashOnDeliverySelected
                                              ? AppColors.greenThemeColor
                                              : AppColors.greyThemeColor,
                                          width: 2)),
                                ),
                                Visibility(
                                  visible: state.isCashOnDeliverySelected,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.greenThemeColor),
                                  ),
                                ),
                              ]),
                              SizedBox(width: 8),
                              Image.asset('assets/cash_on_delivery.png',
                                  scale: 26),
                              SizedBox(width: 5),
                              Text('Cash on delivery',
                                  style: AppTextStyles.screenSubTitles)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      //! razorpay
                      GestureDetector(
                        onTap: () {
                          context
                              .read<PaymentBloc>()
                              .add(SelectRazorpayEvent());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 14),
                          decoration: BoxDecoration(
                            color: isLightTheme(context)
                                ? AppColors.whiteThemeColor
                                : AppColors.lightGreyThemeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: state.isRazorpaySelected
                                              ? AppColors.greenThemeColor
                                              : AppColors.greyThemeColor,
                                          width: 2)),
                                ),
                                Visibility(
                                  visible: state.isRazorpaySelected,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.greenThemeColor),
                                  ),
                                ),
                              ]),
                              SizedBox(width: 10),
                              Image.asset('assets/razorpay.jpeg', scale: 18.5),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                GreenButtonWidget(
                  onTap: () {
                    if (state.isCashOnDeliverySelected == false &&
                        state.isRazorpaySelected == false) {
                      CustomSnackbar.showCustomSnackBar(
                          context, 'Please select a payment method!',
                          icon: Icons.error);
                    } else {
                      NavigationHelper.navigateToWithReplacement(
                          context, ScreenOrderSuccess());
                    }
                  },
                  buttonText: 'Place Order',
                  borderRadius: 25,
                  width: 1,
                  addIcon: true,
                  icon: Icons.check_circle_outline_rounded,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
