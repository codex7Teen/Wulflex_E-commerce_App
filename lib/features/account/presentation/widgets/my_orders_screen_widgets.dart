import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/features/account/presentation/screens/order_details_screen.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class MyOrdersScreenWidgets {
  static Widget buildOrdersContainerWidget(
      BuildContext context, List<OrderModel> orders) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final order = orders[index];
            final product = order.products[0];
            return GestureDetector(
              onTap: () => NavigationHelper.navigateToWithoutReplacement(
                  context, ScreenOrderDetails(product: product, order: order)),
              child: Container(
                padding: const EdgeInsets.all(13),
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
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: SizedBox(
                                width: 26,
                                height: 26,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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

                    const SizedBox(width: 14),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            MyOrdersScreenWidgets.getOrderStatusMessage(
                                order.status),
                            style: AppTextStyles.itemCardBrandText.copyWith(
                                color:
                                    MyOrdersScreenWidgets.getOrderStatusMessage(
                                                order.status) ==
                                            "Delivered successfully"
                                        ? AppColors.greenThemeColor
                                        : AppColors.blackThemeColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${product.brandName} ${product.name}",
                            style: AppTextStyles.itemCardNameText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.greyThemeColor, size: 18)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
          itemCount: orders.length),
    );
  }

  // Order status string helper
  static String getOrderStatusMessage(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Order Recieved";
      case OrderStatus.processing:
        return "Order is processing...";
      case OrderStatus.shipped:
        return "On the way...";
      case OrderStatus.delivered:
        return "Delivered successfully";
      case OrderStatus.cancelled:
        return "Order Cancelled";
    }
  }
}
