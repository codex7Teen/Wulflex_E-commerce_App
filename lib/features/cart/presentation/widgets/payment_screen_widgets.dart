import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/cart/bloc/payment_bloc/payment_bloc.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class PaymentScreenWidgets {
  static Widget buildTotalamountContainer(
      BuildContext context, double totalAmount) {
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
                'TOTAL AMOUNT',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              Column(
                children: const [
                  Icon(Icons.wallet,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2)
                ],
              )
            ],
          ),
          const SizedBox(height: 3),
          Text(
            '₹ ${NumberFormat('#,##,###.##').format(totalAmount)}',
            style: AppTextStyles.paymentPageTotalAmountText,
          )
        ],
      ),
    );
  }

  static Widget buildPaymentOptionsContainer(
      BuildContext context, PaymentState state) {
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
                'PAYMENT OPTIONS',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              const SizedBox(width: 6),
              Column(
                children: const [
                  Icon(Icons.wallet,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2)
                ],
              )
            ],
          ),
          const SizedBox(height: 3),
          // Cash on Delivery Option
          GestureDetector(
            onTap: () {
              context.read<PaymentBloc>().add(SelectCashOnDeliveryEvent());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
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
                  const SizedBox(width: 8),
                  Image.asset('assets/cash_on_delivery.png', scale: 26),
                  const SizedBox(width: 5),
                  Text('Cash on delivery', style: AppTextStyles.screenSubTitles)
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Razorpay Option
          GestureDetector(
            onTap: () {
              context.read<PaymentBloc>().add(SelectRazorpayEvent());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
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
                  const SizedBox(width: 10),
                  Image.asset('assets/razorpay.jpeg', scale: 18.5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
