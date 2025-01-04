import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/data/models/user_model.dart';
import 'package:wulflex/features/account/presentation/screens/rate_product_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/timeline_tile_widget.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/features/home/presentation/screens/view_product_details_screen.dart';
import 'package:wulflex/shared/widgets/custom_alert_box.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class OrderDetailScreenWidgets {
  static Widget buildOrderId(BuildContext context, OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "Order ID - ${order.id.toUpperCase()}",
        style: AppTextStyles.myOrdersScreenMiniText(context),
      ),
    );
  }

  static Widget buildOrderDate(BuildContext context, OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "Ordered Date - ${formatOrderDate(order.orderDate.toString())}",
        style: AppTextStyles.myOrdersScreenMiniText(context),
      ),
    );
  }

  static Widget buildAccountInformation(BuildContext context, UserModel user) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme(context)
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'ACCOUNT INFORMATION',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              SizedBox(width: 6),
              Column(
                children: [
                  Icon(Icons.person,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2)
                ],
              )
            ],
          ),
          SizedBox(height: 3),
          Text(
            user.name,
            style: AppTextStyles.screenSubTitles,
          )
        ],
      ),
    );
  }

  static Widget buildPaymentMode(BuildContext context, OrderModel order) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: isLightTheme(context)
              ? AppColors.lightGreyThemeColor
              : AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'PAYMENT METHOD',
                style: AppTextStyles.screenSubHeadings(context,
                    fixedBlackColor: true),
              ),
              SizedBox(width: 6),
              Column(
                children: [
                  Icon(Icons.wallet,
                      color: AppColors.blackThemeColor, size: 22),
                  SizedBox(height: 2)
                ],
              )
            ],
          ),
          SizedBox(height: 3),
          Text(
            order.paymentMode,
            style: AppTextStyles.screenSubTitles,
          )
        ],
      ),
    );
  }

  static buildProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () => NavigationHelper.navigateToWithoutReplacement(
          context, ScreenViewProducts(productModel: product)),
      child: Container(
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
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.brandName,
                            style: AppTextStyles.itemCardBrandText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                              product.selectedSize != null
                                  ? 'SIZE: ${product.selectedSize}'
                                  : 'WEIGHT: ${product.selectedWeight}',
                              style: AppTextStyles.orderQuantityText),
                        ],
                      ),
                      Text(
                        product.name,
                        style: AppTextStyles.itemCardNameText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 13),
                      Row(
                        children: [
                          Text(
                            "₹${NumberFormat('#,##,###.##').format(product.retailPrice)}",
                            style: AppTextStyles.itemCardSecondSubTitleText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "₹${NumberFormat('#,##,###.##').format(product.offerPrice)}",
                            style: AppTextStyles.itemCardSubTitleText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14),
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
              ],
            ),
            SizedBox(height: 8),
            Text('QUANTITY: ${product.quantity}',
                style: AppTextStyles.orderQuantityText),
          ],
        ),
      ),
    );
  }

  static Widget buildOrderStatusText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        'ORDER STATUS',
        style: AppTextStyles.screenSubHeadings(context),
      ),
    );
  }

  static Widget buildOrderStatusTimeline(
      BuildContext context, OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // Order pending
          TimelineTileWidget(
            isCancelled: false,
            isFirst: true,
            isLast: false,
            isPast: order.status == OrderStatus.pending ||
                order.status == OrderStatus.processing ||
                order.status == OrderStatus.shipped ||
                order.status == OrderStatus.delivered,
            endChild: Text(
              'Order Recieved',
              style: AppTextStyles.screenOrderStatusMiniSubTitles(context,
                  isPast: order.status == OrderStatus.pending ||
                      order.status == OrderStatus.processing ||
                      order.status == OrderStatus.shipped ||
                      order.status == OrderStatus.delivered),
            ),
          ),
          // Order Processing
          TimelineTileWidget(
              isCancelled: false,
              isFirst: false,
              isLast: false,
              isPast: order.status == OrderStatus.processing ||
                  order.status == OrderStatus.shipped ||
                  order.status == OrderStatus.delivered,
              endChild: Text(
                'Order Processing',
                style: AppTextStyles.screenOrderStatusMiniSubTitles(context,
                    isPast: order.status == OrderStatus.processing ||
                        order.status == OrderStatus.shipped ||
                        order.status == OrderStatus.delivered),
              )),
          // Order on the way
          TimelineTileWidget(
              isCancelled: false,
              isFirst: false,
              isLast: false,
              isPast: order.status == OrderStatus.shipped ||
                  order.status == OrderStatus.delivered,
              endChild: Text(
                'Item on the way',
                style: AppTextStyles.screenOrderStatusMiniSubTitles(context,
                    isPast: order.status == OrderStatus.shipped ||
                        order.status == OrderStatus.delivered),
              )),
          // Order delivered
          TimelineTileWidget(
              isCancelled: false,
              isFirst: false,
              isLast: order.status != OrderStatus.cancelled ? true : false,
              isPast: order.status == OrderStatus.delivered,
              endChild: Text(
                'Delivered Successfully',
                style: AppTextStyles.screenOrderStatusMiniSubTitles(context,
                    isPast: order.status == OrderStatus.delivered),
              )),
          // Order cancelled
          order.status == OrderStatus.cancelled
              ? TimelineTileWidget(
                  isCancelled: true,
                  isFirst: false,
                  isLast: true,
                  isPast: order.status == OrderStatus.delivered,
                  endChild: Text(
                    'Order Cancelled',
                    style: AppTextStyles.screenOrderStatusMiniSubTitles(context,
                        isPast: order.status == OrderStatus.cancelled),
                  ))
              : SizedBox()
        ],
      ),
    );
  }

  static Widget buildCancelButton(BuildContext context, OrderModel order) {
    return Visibility(
      visible: order.status == OrderStatus.pending ||
          order.status == OrderStatus.processing ||
          order.status == OrderStatus.shipped,
      child: GestureDetector(
        onTap: () => CustomAlertBox.showConfirmationAlertDialog(
            buttonConfirmText: 'Confirm',
            titleText:
                'Are you sure you want to cancel the order? This action cannot be undone.',
            context, onDeleteConfirmed: () {
          context.read<OrderBloc>().add(UpdateOrderStatusEvent(
              orderId: order.id, newStatus: OrderStatus.cancelled));
        }, icon: Icons.check),
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.greenThemeColor,
                borderRadius: BorderRadius.circular(18)),
            child: Text('Request cancellation ?',
                style: AppTextStyles.selectAddressText),
          ),
        ),
      ),
    );
  }

  static Widget buildDivider(BuildContext context) {
    return Divider(
        color: isLightTheme(context)
            ? AppColors.lightGreyThemeColor
            : AppColors.greyThemeColor);
  }

  static Widget buildDeliveryAddressText(BuildContext context) {
    return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            'DELIVERY ADDRESS',
                            style: AppTextStyles.screenSubHeadings(context),
                          ),
                        );
  }

  static Widget buildAddressSection(BuildContext context, OrderModel order) {
    return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.address.name,
                                    style:
                                        AppTextStyles.addressNameText(context),
                                  ),
                                  SizedBox(height: 10),
                                  Text(order.address.houseName,
                                      style: AppTextStyles.addressListItemsText(
                                          context)),
                                  Text(
                                      "${order.address.areaName}, ${order.address.cityName}",
                                      style: AppTextStyles.addressListItemsText(
                                          context)),
                                  Text(
                                      "${order.address.stateName}, ${order.address.pincode}",
                                      style: AppTextStyles.addressListItemsText(
                                          context)),
                                  SizedBox(height: 10),
                                  Text("Phone: ${order.address.phoneNumber}",
                                      style: AppTextStyles.addressListItemsText(
                                          context)),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        );
  }

  static Widget buildRateButton(BuildContext context, OrderModel order, ProductModel product) {
    return Visibility(
                          visible: order.status == OrderStatus.delivered,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                  color: isLightTheme(context)
                                      ? AppColors.lightGreyThemeColor
                                      : AppColors.greyThemeColor),
                              SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text(
                                  'RATE THE PRODUCT',
                                  style:
                                      AppTextStyles.screenSubHeadings(context),
                                ),
                              ),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => NavigationHelper
                                    .navigateToWithoutReplacement(
                                        context,
                                        ScreenRateProduct(
                                            productModel: product)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: AppColors.greenThemeColor,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Text('RATE HERE.',
                                        style: AppTextStyles.selectAddressText),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
  }

  // Format Order Date
  static String formatOrderDate(String rawDate) {
    // Parse the raw date string into a DateTime object
    DateTime parsedDate = DateTime.parse(rawDate);
    // Format the date and time
    String formattedDate = DateFormat('MMMM d yyyy | HH:mm').format(parsedDate);
    return formattedDate;
  }
}
