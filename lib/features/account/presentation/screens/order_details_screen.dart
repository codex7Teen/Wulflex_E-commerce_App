import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/order_detail_screen_widgets.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenOrderDetails extends StatelessWidget {
  final OrderModel order;
  final ProductModel product;
  const ScreenOrderDetails(
      {super.key, required this.order, required this.product});

  @override
  Widget build(BuildContext context) {
    log(product.id.toString());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ORDER DETAILS', 0.09),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderUpdateSuccess) {
            CustomSnackbar.showCustomSnackBar(context, "Order cancelled!",
                appearFromTop: true);
            Future.delayed(const Duration(milliseconds: 500), () {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          return BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Center(child: CircularProgressIndicator());
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
                        OrderDetailScreenWidgets.buildOrderId(context, order),
                        const SizedBox(height: 8),
                        OrderDetailScreenWidgets.buildOrderDate(context, order),
                        const SizedBox(height: 18),
                        OrderDetailScreenWidgets.buildAccountInformation(
                            context, user),
                        const SizedBox(height: 18),
                        OrderDetailScreenWidgets.buildPaymentMode(
                            context, order),
                        const SizedBox(height: 18),
                        OrderDetailScreenWidgets.buildProductCard(
                            context, product),
                        const SizedBox(height: 18),
                        OrderDetailScreenWidgets.buildOrderStatusText(context),
                        OrderDetailScreenWidgets.buildOrderStatusTimeline(
                            context, order),
                        Visibility(
                            visible: order.status == OrderStatus.pending ||
                                order.status == OrderStatus.processing ||
                                order.status == OrderStatus.shipped,
                            child: const SizedBox(height: 3)),
                        OrderDetailScreenWidgets.buildCancelButton(
                            context, order),
                        Visibility(
                            visible: order.status == OrderStatus.pending ||
                                order.status == OrderStatus.processing ||
                                order.status == OrderStatus.shipped,
                            child: const SizedBox(height: 6)),
                        OrderDetailScreenWidgets.buildDivider(context),
                        const SizedBox(height: 2),
                        OrderDetailScreenWidgets.buildDeliveryAddressText(
                            context),
                        const SizedBox(height: 2),
                        OrderDetailScreenWidgets.buildAddressSection(
                            context, order),
                        OrderDetailScreenWidgets.buildRateButton(
                            context, order, product)
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                  child:
                      Text('Something went wrong. Check network connection!'));
            },
          );
        },
      ),
    );
  }
}
