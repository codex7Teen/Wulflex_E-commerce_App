import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/cart/presentation/screens/order_summary_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_cart_card_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isLightTheme(context)
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('CART', style: AppTextStyles.appbarTextBig(context)),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartLoaded) {
              CustomSnackbar.showCustomSnackBar(
                  appearFromTop: true, context, 'Item removed from cart');
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(
                      'Please add product to cart. TODOD IMPLEMENT A LOTTIE HERE'),
                );
              }
              final cartItems = state.products;

              // calculate subtotal, discount and total
              // Calculate subtotal, discount, and total for all products in the cart
              final subtotal = cartItems.fold(
                  0.0, (sum, product) => sum + product.retailPrice);

              final discount = cartItems.fold(
                  0.0,
                  (sum, product) =>
                      sum + (product.retailPrice - product.offerPrice));

              final total = cartItems.fold(
                  0.0, (sum, product) => sum + product.offerPrice);

              return Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 14, left: 18, right: 18),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final product = cartItems[index];
                              return buildCustomCartCard(context, product);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 245,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 239,
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyThemeColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'PRICE DETAILS',
                                  style: AppTextStyles.screenSubHeadings(
                                      context,
                                      fixedBlackColor: true),
                                ),
                                SizedBox(width: 6),
                                Column(
                                  children: [
                                    Icon(Icons.wallet,
                                        color: AppColors.blackThemeColor,
                                        size: 22),
                                    SizedBox(height: 2.5)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Subtotal',
                                  style:
                                      AppTextStyles.cartSubtotalAndDiscountText,
                                ),
                                Spacer(),
                                Text(
                                  '₹ ${subtotal.toString()}',
                                  style: AppTextStyles
                                      .cartSubtotalAndDiscountAmountStyle,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Discount',
                                  style:
                                      AppTextStyles.cartSubtotalAndDiscountText,
                                ),
                                Spacer(),
                                Text(
                                  '₹ –${discount.toString()}',
                                  style: AppTextStyles
                                      .cartSubtotalAndDiscountAmountStyle,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(
                                color: AppColors.hardLightGeryThemeColor,
                                thickness: 0.3),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Total Amount',
                                  style: AppTextStyles.cartTotalText,
                                ),
                                Spacer(),
                                Text(
                                  '₹ ${total.toString()}',
                                  style: AppTextStyles.cartTotalAmountText,
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                NavigationHelper.navigateToWithoutReplacement(
                                    context, ScreenOrderSummary());
                              },
                              child: GreenButtonWidget(
                                addIcon: true,
                                icon: Icons.shopping_cart_checkout_rounded,
                                buttonText: 'Checkout Securely',
                                borderRadius: 25,
                                width: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return Center(child: SizedBox.shrink());
          },
        ));
  }
}
