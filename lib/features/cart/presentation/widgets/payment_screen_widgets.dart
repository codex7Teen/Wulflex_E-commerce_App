import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
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
              const Column(
                children: [
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
              const Column(
                children: [
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

class PaymentScreenShimmer extends StatelessWidget {
  const PaymentScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      // Shimmer for AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Shimmer.fromColors(
          baseColor: isLightTheme(context)
              ? const Color(0xFFEEEEEE)
              : const Color(0xFF333333),
          highlightColor: isLightTheme(context)
              ? const Color(0xFFF5F5F5)
              : const Color(0xFF434343),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            title: Container(
              height: 20,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 24),
        child: Shimmer.fromColors(
          baseColor: isLightTheme(context)
              ? const Color(0xFFEEEEEE)
              : const Color(0xFF333333),
          highlightColor: isLightTheme(context)
              ? const Color(0xFFF5F5F5)
              : const Color(0xFF434343),
          child: Column(
            children: [
              // Total Amount Container Shimmer
              Container(
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 150,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              
              // Payment Options Container Shimmer
              Container(
                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 140,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Cash on Delivery Option Shimmer
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 120,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Razorpay Option Shimmer
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Place Order Button Shimmer
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
