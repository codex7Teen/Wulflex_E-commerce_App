import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/account/presentation/screens/rate_product_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/timeline_tile_widget.dart';
import 'package:wulflex/features/home/presentation/screens/view_product_details_screen.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenOrderDetails extends StatelessWidget {
  final OrderModel order;
  final ProductModel product;
  const ScreenOrderDetails(
      {super.key, required this.order, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ORDER DETAILS', 0.09),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            final user = state.user;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 18, bottom: 75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Order ID - ${order.id.toUpperCase()}",
                        style: AppTextStyles.myOrdersScreenMiniText(context),
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                                      color: AppColors.blackThemeColor,
                                      size: 22),
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
                    ),
                    SizedBox(height: 18),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 18),
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
                                      color: AppColors.blackThemeColor,
                                      size: 22),
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
                    ),
                    SizedBox(height: 18),
                    GestureDetector(
                      onTap: () =>
                          NavigationHelper.navigateToWithoutReplacement(context,
                              ScreenViewProducts(productModel: product)),
                      child: Container(
                        padding: EdgeInsets.all(13),
                        width: MediaQuery.of(context).size.width, // Full width
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyThemeColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
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
                                  SizedBox(height: 13),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${product.retailPrice.round()}",
                                        style: AppTextStyles
                                            .itemCardSecondSubTitleText,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "₹${product.offerPrice.round()}",
                                        style:
                                            AppTextStyles.itemCardSubTitleText,
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
                                      Image.asset(
                                          'assets/wulflex_logo_nobg.png'),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: CircularProgressIndicator(
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'ORDER STATUS',
                        style: AppTextStyles.screenSubHeadings(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // Order pending
                          TimelineTileWidget(
                            isFirst: true,
                            isLast: false,
                            isPast: order.status == OrderStatus.pending ||
                                order.status == OrderStatus.processing ||
                                order.status == OrderStatus.shipped ||
                                order.status == OrderStatus.delivered,
                            endChild: Text(
                              'Order Recieved',
                              style:
                                  AppTextStyles.screenOrderStatusMiniSubTitles(
                                      context,
                                      isPast: order.status ==
                                              OrderStatus.pending ||
                                          order.status ==
                                              OrderStatus.processing ||
                                          order.status == OrderStatus.shipped ||
                                          order.status ==
                                              OrderStatus.delivered),
                            ),
                          ),
                          // Order Processing
                          TimelineTileWidget(
                              isFirst: false,
                              isLast: false,
                              isPast: order.status == OrderStatus.processing ||
                                  order.status == OrderStatus.shipped ||
                                  order.status == OrderStatus.delivered,
                              endChild: Text(
                                'Order Processing',
                                style: AppTextStyles
                                    .screenOrderStatusMiniSubTitles(context,
                                        isPast: order.status ==
                                                OrderStatus.processing ||
                                            order.status ==
                                                OrderStatus.shipped ||
                                            order.status ==
                                                OrderStatus.delivered),
                              )),
                          // Order on the way
                          TimelineTileWidget(
                              isFirst: false,
                              isLast: false,
                              isPast: order.status == OrderStatus.shipped ||
                                  order.status == OrderStatus.delivered,
                              endChild: Text(
                                'Item on the way',
                                style: AppTextStyles
                                    .screenOrderStatusMiniSubTitles(context,
                                        isPast: order.status ==
                                                OrderStatus.shipped ||
                                            order.status ==
                                                OrderStatus.delivered),
                              )),
                          // Order delivered
                          TimelineTileWidget(
                              isFirst: false,
                              isLast: true,
                              isPast: order.status == OrderStatus.delivered,
                              endChild: Text(
                                'Delivered Successfully',
                                style: AppTextStyles
                                    .screenOrderStatusMiniSubTitles(context,
                                        isPast: order.status ==
                                            OrderStatus.delivered),
                              )),
                        ],
                      ),
                    ),
                    Divider(
                        color: isLightTheme(context)
                            ? AppColors.lightGreyThemeColor
                            : AppColors.greyThemeColor),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'DELIVERY ADDRESS',
                        style: AppTextStyles.screenSubHeadings(context),
                      ),
                    ),
                    SizedBox(height: 2),
                    Container(
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
                                style: AppTextStyles.addressNameText(context),
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
                    ),
                    Visibility(
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
                              style: AppTextStyles.screenSubHeadings(context),
                            ),
                          ),
                          SizedBox(height: 6),
                          GestureDetector(
                            onTap: () =>
                                NavigationHelper.navigateToWithoutReplacement(
                                    context, ScreenRateProduct(productModel: product)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.greenThemeColor,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Text('RATE HERE.',
                                    style: AppTextStyles.selectAddressText),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
