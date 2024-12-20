import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/home/presentation/screens/view_product_details_screen.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

Widget buildCustomCartCard(BuildContext context, ProductModel product) {
  return Container(
    padding: EdgeInsets.all(13),
    width: MediaQuery.of(context).size.width, // Full width
    decoration: BoxDecoration(
      color: AppColors.lightGreyThemeColor,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Product Image
            GestureDetector(
              onTap: () => NavigationHelper.navigateToWithoutReplacement(
                  context, ScreenViewProducts(productModel: product)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 84, // Fixed height
                  width: MediaQuery.of(context).size.width * 0.21,
                  child: Image.network(
                    product.imageUrls[0],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset('assets/wulflex_logo_nobg.png'),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            SizedBox(width: 14),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => NavigationHelper.navigateToWithoutReplacement(
                        context, ScreenViewProducts(productModel: product)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.brandName,
                            style: AppTextStyles.itemCardBrandText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              product.selectedSize ??
                                  product.selectedWeight ??
                                  '',
                              style: AppTextStyles.selectedSizeOrWeightText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => NavigationHelper.navigateToWithoutReplacement(
                        context, ScreenViewProducts(productModel: product)),
                    child: Text(
                      product.name,
                      style: AppTextStyles.itemCardNameText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 9),
                  Row(
                    children: [
                      Text(
                        "₹${product.retailPrice.round()}",
                        style: AppTextStyles.itemCardSecondSubTitleText,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "₹${product.offerPrice.round()}",
                        style: AppTextStyles.itemCardSubTitleText,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.read<CartBloc>().add(RemoveFromCartEvent(
                              productId: product.cartItemId!));
                        },
                        child: Container(
                          padding: EdgeInsets.all(7.5),
                          decoration: BoxDecoration(
                              color: AppColors.whiteThemeColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                size: 18,
                                color: AppColors.darkishGrey,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Remove',
                                style:
                                    AppTextStyles.itemCardDeleteContainerText,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Text('Quantity: ', style: AppTextStyles.orderQuantityText),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    color: AppColors.whiteThemeColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        width: 0.2, color: AppColors.greyThemeColor)),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartItemQuantityLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.5, horizontal: 23),
                        child: Center(
                            child: SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.4))),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: product.quantity > 1
                              ? () {
                                  // Decrement quantity
                                  context.read<CartBloc>().add(
                                      UpdateCartItemQuantityEvent(
                                          productId: product.cartItemId!,
                                          quantity: product.quantity - 1));
                                }
                              : null,
                          child: Icon(
                            Icons.remove,
                            color: AppColors.greyThemeColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(product.quantity.toString(),
                            style: AppTextStyles.orderQuantityText),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            // Increment quantity
                            context.read<CartBloc>().add(
                                UpdateCartItemQuantityEvent(
                                    productId: product.cartItemId!,
                                    quantity: product.quantity + 1));
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.greyThemeColor,
                            size: 16,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
