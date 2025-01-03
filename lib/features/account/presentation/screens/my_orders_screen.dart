import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/features/account/presentation/screens/order_details_screen.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenMyOrders extends StatelessWidget {
  final bool isBackButtonVisible;
  const ScreenMyOrders({super.key, this.isBackButtonVisible = true});

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(FetchUserOrdersEvent());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(
          context, 'My Orders', 0.145, isBackButtonVisible),
      body: Stack(
        children: [
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderError) {
                return Text(state.errorMessage);
              } else if (state is OrderLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrdersLoaded) {
                // Sort orders by date in descending order (latest first)
                final orders = List<OrderModel>.from(state.orders)
                  ..sort((a, b) => b.orderDate.compareTo(a.orderDate));
                if (orders.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 18, bottom: 18),
                    child: Column(children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final order = orders[index];
                              final product = order.products[0];
                              return GestureDetector(
                                onTap: () => NavigationHelper
                                    .navigateToWithoutReplacement(
                                        context,
                                        ScreenOrderDetails(
                                            product: product, order: order)),
                                child: Container(
                                  padding: EdgeInsets.all(13),
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Full width
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.21,
                                          child: Image.network(
                                            product.imageUrls[0],
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    'assets/wulflex_logo_nobg.png'),
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: SizedBox(
                                                  width: 26,
                                                  height: 26,
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
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

                                      SizedBox(width: 14),

                                      // Product Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _getOrderStatusMessage(
                                                  order.status),
                                              style: AppTextStyles
                                                  .itemCardBrandText
                                                  .copyWith(
                                                      color: _getOrderStatusMessage(
                                                                  order
                                                                      .status) ==
                                                              "Delivered successfully"
                                                          ? AppColors
                                                              .greenThemeColor
                                                          : AppColors
                                                              .blackThemeColor),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "${product.brandName} ${product.name}",
                                              style: AppTextStyles
                                                  .itemCardNameText,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: AppColors.greyThemeColor,
                                          size: 18)
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemCount: orders.length),
                      )
                    ]),
                  );
                } else {
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
                        SizedBox(height: 90)
                      ],
                    ),
                  );
                }
              }
              return Text('sorry');
            },
          ),
          Visibility(
            visible: !isBackButtonVisible,
            child: Positioned(
                bottom: 18,
                left: 18,
                right: 18,
                child: GreenButtonWidget(
                    buttonText: 'Continue shopping...',
                    borderRadius: 25,
                    width: 1,
                    onTap: () => NavigationHelper.navigateToWithReplacement(
                        context, MainScreen()))),
          )
        ],
      ),
    );
  }

// Order status string helper
  String _getOrderStatusMessage(OrderStatus status) {
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
