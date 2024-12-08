import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

Widget buildCustomCartCard(BuildContext context, ProductModel product) {
  return Container(
    padding: EdgeInsets.all(13),
    width: MediaQuery.of(context).size.width, // Full width
    decoration: BoxDecoration(
      color: AppColors.lightGreyThemeColor,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        // Product Image
        ClipRRect(
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

        SizedBox(width: 14),

        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.brandName,
                style: AppTextStyles.itemCardBrandText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                product.name,
                style: AppTextStyles.itemCardNameText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                      context
                          .read<CartBloc>()
                          .add(RemoveFromCartEvent(productId: product.id!));
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
                            style: AppTextStyles.itemCardDeleteContainerText,
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
  );
}
