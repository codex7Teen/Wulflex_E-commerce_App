import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/cart/presentation/widgets/order_summary_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenOrderSummary extends StatelessWidget {
  const ScreenOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger FetchUserProfileEvent and fetch address event when the screen is built
    context.read<UserProfileBloc>().add(FetchUserProfileEvent());
    context.read<AddressBloc>().add(FetchAddressEvent());
    context.read<CartBloc>().add(FetchCartEvent());
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ORDER SUMMARY', 0.06),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartError) {
            return Center(child: Text('Failed to load data'));
          } else if (state is CartLoaded) {
            final cartItemsList = state.products;

            // Calculate subtotal, discount, and total for all products in the cart
            final subtotal = cartItemsList.fold(
                0.0, (sum, product) => sum + product.retailPrice);
            final discount = cartItemsList.fold(
                0.0,
                (sum, product) =>
                    sum + (product.retailPrice - product.offerPrice));
            final total = cartItemsList.fold(
                0.0, (sum, product) => sum + product.offerPrice);

            return BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserProfileError) {
                  // display error
                  Center(child: Text('User Profile error'));
                } else if (state is UserProfileLoaded) {
                  final user = state.user;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 18, left: 18, right: 18, bottom: 18),
                      child: Column(
                        children: [
                          OrderSummaryScreenWidgets
                              .buildAccountInformationContainer(context, user),
                          SizedBox(height: 18),
                          OrderSummaryScreenWidgets
                              .buildDeliveryAddressContainer(context),
                          SizedBox(height: 18),
                          OrderSummaryScreenWidgets.buildItemsContainer(
                              context, cartItemsList),
                          SizedBox(height: 18),
                          // Just showing a sizedbox the strcture the ui.
                          cartItemsList.length == 1
                              ? SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.08)
                              : SizedBox(),
                          OrderSummaryScreenWidgets
                              .buildPricedetailsAndProceedButton(
                                  context, subtotal, discount, total)
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                    child: Text('Some Unknown error have occured.'));
              },
            );
          }
          return const Center(child: Text('Some Unknown error have occured.'));
        },
      ),
    );
  }
}
