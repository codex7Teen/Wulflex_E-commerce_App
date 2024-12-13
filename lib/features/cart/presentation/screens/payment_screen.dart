import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/app_constants.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/features/cart/bloc/payment_bloc/payment_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/order_success_screen.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenPayment extends StatefulWidget {
  final List<ProductModel> cartProducts;
  final AddressModel selectedAddress;
  final double totalAmount;
  const ScreenPayment(
      {super.key,
      required this.totalAmount,
      required this.cartProducts,
      required this.selectedAddress});

  @override
  ScreenPaymentState createState() => ScreenPaymentState();
}

class ScreenPaymentState extends State<ScreenPayment> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Clear all cart items
    context.read<CartBloc>().add(ClearAllCartItemsEvent());
    // Create order
    context.read<OrderBloc>().add(CreateOrderEvent(
        products: widget.cartProducts,
        address: widget.selectedAddress,
        paymentMode: 'Razorpay'));

    // Handle successful payment
    CustomSnackbar.showCustomSnackBar(
        context, 'Payment Successful! Order Placed.',
        icon: Icons.check_circle);

    NavigationHelper.navigateToWithReplacement(
        context, const ScreenOrderSuccess());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    CustomSnackbar.showCustomSnackBar(
        context, 'Payment Failed: ${response.message}',
        icon: Icons.error);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    CustomSnackbar.showCustomSnackBar(
        context, 'External Wallet Selected: ${response.walletName}',
        icon: Icons.wallet);
  }

  void _startRazorpayPayment() {
    var options = {
      'key': razorpayApiKey, // Razorpay api key
      'amount': (widget.totalAmount * 100).toInt(), // Amount in paise
      'name': 'Wulflex Shopping',
      'description': 'Payment for Order',
      'prefill': {
        'contact': '', // Add customer phone number
        'email': '' // Add customer email
      },
      'external': {
        'wallets': ['paytm'] // Optional: Add supported wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error starting Razorpay: $e');
      CustomSnackbar.showCustomSnackBar(
          context, 'Failed to start payment. Please try again.',
          icon: Icons.error);
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

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
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                        '₹ ${widget.totalAmount.toString()}',
                        style: AppTextStyles.paymentPageTotalAmountText,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                          context
                              .read<PaymentBloc>()
                              .add(SelectCashOnDeliveryEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
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
                              const SizedBox(width: 8),
                              Image.asset('assets/cash_on_delivery.png',
                                  scale: 26),
                              const SizedBox(width: 5),
                              Text('Cash on delivery',
                                  style: AppTextStyles.screenSubTitles)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Razorpay Option
                      GestureDetector(
                        onTap: () {
                          context
                              .read<PaymentBloc>()
                              .add(SelectRazorpayEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
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
                              const SizedBox(width: 10),
                              Image.asset('assets/razorpay.jpeg', scale: 18.5),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                GreenButtonWidget(
                  onTap: () {
                    if (state.isCashOnDeliverySelected == false &&
                        state.isRazorpaySelected == false) {
                      CustomSnackbar.showCustomSnackBar(
                          context, 'Please select a payment method!',
                          icon: Icons.error);
                    } else if (state.isRazorpaySelected) {
                      // Call Razorpay payment method
                      _startRazorpayPayment();
                    } else {
                      // Clear all cart items
                      context.read<CartBloc>().add(ClearAllCartItemsEvent());
                      // Create order
                      context.read<OrderBloc>().add(CreateOrderEvent(
                          products: widget.cartProducts,
                          address: widget.selectedAddress,
                          paymentMode: 'Cash on delivery'));
                      NavigationHelper.navigateToWithReplacement(
                          context, const ScreenOrderSuccess());
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
