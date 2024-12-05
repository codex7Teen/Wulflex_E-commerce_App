import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/cart_bloc/cart_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_cart_card_widget.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

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
                  context, 'Item removed from cart');
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
              return Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 14, left: 18, right: 18),
                    child: Expanded(
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 205,
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyThemeColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Subtotal',
                                  style:
                                      AppTextStyles.cartSubtotalAndDiscountText,
                                ),
                                Spacer(),
                                Text(
                                  '₹ 3214.0',
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
                                  '₹ -4325.0',
                                  style: AppTextStyles
                                      .cartSubtotalAndDiscountAmountStyle,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(
                                color: AppColors.greyThemeColor,
                                thickness: 0.5),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: AppTextStyles.cartTotalText,
                                ),
                                Spacer(),
                                Text(
                                  '₹ 5341.0',
                                  style: AppTextStyles.cartTotalAmountText,
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            GreenButtonWidget(
                              buttonText: 'Checkout Securely',
                              borderRadius: 25,
                              width: 1,
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
