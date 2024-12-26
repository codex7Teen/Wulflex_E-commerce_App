import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/cart/presentation/screens/order_summary_screen.dart';
import 'package:wulflex/shared/widgets/custom_cart_card_widget.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

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
    );
  }

  static Widget buildBottomPricedetailAndCheckoutContainer(
      BuildContext context, double subtotal, double discount, double total) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 239,
        decoration: BoxDecoration(
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
                  SizedBox(width: 6),
                  Column(
                    children: [
                      Icon(Icons.wallet,
                          color: AppColors.blackThemeColor, size: 22),
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
                    style: AppTextStyles.cartSubtotalAndDiscountText,
                  ),
                  Spacer(),
                  Text(
                    '₹ ${NumberFormat('#,##,###.##').format(subtotal)}',
                    style: AppTextStyles.cartSubtotalAndDiscountAmountStyle,
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Discount',
                    style: AppTextStyles.cartSubtotalAndDiscountText,
                  ),
                  Spacer(),
                  Text(
                    '₹ –${NumberFormat('#,##,###.##').format(discount)}',
                    style: AppTextStyles.cartSubtotalAndDiscountAmountStyle,
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(color: AppColors.hardLightGeryThemeColor, thickness: 0.3),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Total Amount',
                    style: AppTextStyles.cartTotalText,
                  ),
                  Spacer(),
                  Text(
                    '₹ ${NumberFormat('#,##,###.##').format(total)}',
                    style: AppTextStyles.cartTotalAmountText,
                  )
                ],
              ),
              SizedBox(height: 10),
              GreenButtonWidget(
                onTap: () {
                  NavigationHelper.navigateToWithoutReplacement(
                      context, ScreenOrderSummary());
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
}
