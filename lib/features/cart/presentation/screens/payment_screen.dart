import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/app_constants.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/features/cart/bloc/payment_bloc/payment_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/order_success_screen.dart';
import 'package:wulflex/features/cart/presentation/widgets/payment_screen_widgets.dart';
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
                PaymentScreenWidgets.buildTotalamountContainer(
                    context, widget.totalAmount),
                const SizedBox(height: 18),
                PaymentScreenWidgets.buildPaymentOptionsContainer(
                    context, state),
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
