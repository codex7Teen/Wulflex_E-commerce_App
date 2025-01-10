import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/navigation/bottom_navigation_screen.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/features/account/presentation/widgets/my_orders_screen_widgets.dart';
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
                return MyOrdersScreenWidgets.buildOrdersShimmer();
              } else if (state is OrdersLoaded) {
                // Sort orders by date in descending order (latest first)
                final orders = List<OrderModel>.from(state.orders)
                  ..sort((a, b) => b.orderDate.compareTo(a.orderDate));
                if (orders.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 6, right: 6, top: 18, bottom: 18),
                    child: Column(children: [
                      MyOrdersScreenWidgets.buildOrdersContainerWidget(
                          context, orders)
                    ]),
                  );
                } else {
                  return MyOrdersScreenWidgets.buildNoOrdersPlacedDisplay(
                      context);
                }
              }
              return const Text('sorry');
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
                        context, const MainScreen()))),
          )
        ],
      ),
    );
  }
}
