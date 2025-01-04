import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/cart/presentation/screens/order_summary_screen.dart';
import 'package:wulflex/shared/widgets/custom_cart_card_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class CartWidgets {
  static PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text('CART', style: AppTextStyles.appbarTextBig(context)),
    );
  }

  static Widget buildCartItemsCard(List<ProductModel> cartItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
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
                return const SizedBox(height: 15);
              },
            ),
          ),
          const SizedBox(
            height: 245,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  static Widget buildBottomPricedetailAndCheckoutContainer(
      BuildContext context, double subtotal, double discount, double total) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 239,
        decoration: const BoxDecoration(
            color: AppColors.lightGreyThemeColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
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
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
              const Divider(color: AppColors.hardLightGeryThemeColor, thickness: 0.3),
              const SizedBox(height: 5),
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
              const SizedBox(height: 10),
              GreenButtonWidget(
                onTap: () {
                  NavigationHelper.navigateToWithoutReplacement(
                      context, const ScreenOrderSummary());
                },
                addIcon: true,
                icon: Icons.shopping_cart_checkout_rounded,
                buttonText: 'Checkout Securely',
                borderRadius: 25,
                width: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildCartEmptyDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLightTheme(context)
              ? Lottie.asset('assets/lottie/cart_empty_lottie_black.json',
                  width: 190, repeat: false)
              : Lottie.asset('assets/lottie/cart_empty_lottie_white.json',
                  width: 190, repeat: false),
          Text(
            'Your cart is empty.\nStart adding your items!',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyScreenText(context),
          ),
          const SizedBox(height: 90)
        ],
      ),
    );
  }
}
