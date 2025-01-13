import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/features/account/presentation/screens/order_details_screen.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class MyOrdersScreenWidgets {
  static Widget buildOrdersContainerWidget(
      BuildContext context, List<OrderModel> orders) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final order = orders[index];
          final product = order.products[0];
          return FadeIn(
            child: GestureDetector(
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
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                                  color: MyOrdersScreenWidgets
                                              .getOrderStatusMessage(
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

  static Widget buildOrdersShimmer() {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 18, bottom: 18),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 4, // Show 4 shimmer cards
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isLightTheme(context)
                        ? AppColors.whiteThemeColor
                        : AppColors.blackThemeColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Shimmer.fromColors(
                    baseColor: isLightTheme(context)
                        ? Colors.grey[300]!
                        : Colors.grey[800]!,
                    highlightColor: isLightTheme(context)
                        ? Colors.grey[100]!
                        : Colors.grey[700]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order Date shimmer
                        Container(
                          width: 200,
                          height: 13,
                          decoration: BoxDecoration(
                            color: AppColors.whiteThemeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            // Product Image shimmer
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 84,
                                width: MediaQuery.of(context).size.width * 0.21,
                                color: AppColors.whiteThemeColor,
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Product Details shimmer
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Status shimmer
                                  Container(
                                    width: 140,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteThemeColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Product name shimmer
                                  Container(
                                    width: 180,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteThemeColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Additional details like price
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        width: 60,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Arrow icon shimmer
                            Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: AppColors.whiteThemeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Additional order details at bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.whiteThemeColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.whiteThemeColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
