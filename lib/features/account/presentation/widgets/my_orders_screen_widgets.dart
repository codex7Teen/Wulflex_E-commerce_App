import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Date
                  Text(
                    "Ordered Date - ${formatOrderDate(order.orderDate.toString())}",
                    style: GoogleFonts.robotoCondensed(
                      letterSpacing: 0.6,
                      fontSize: 13,
                      color: AppColors.greyThemeColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 84,
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
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
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
                                        : AppColors.blackThemeColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${product.brandName} ${product.name}",
                              style: AppTextStyles.itemCardNameText.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.greyThemeColor,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 15);
        },
        itemCount: orders.length,
      ),
    );
  }

// Format Order Date
  static String formatOrderDate(String rawDate) {
    DateTime parsedDate = DateTime.parse(rawDate);
    String formattedDate = DateFormat('MMMM d, yyyy').format(parsedDate);
    return formattedDate;
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

  static Widget buildNoOrdersPlacedDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/no_orders_lottie.json',
              width: 190, repeat: false),
          Text(
            'Oops! No orders here yet. 🛒\nLet’s fix that—shop your favorites today!',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyScreenText(context),
          ),
          const SizedBox(height: 90)
        ],
      ),
    );
  }
}
