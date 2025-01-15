import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/cart/presentation/widgets/cart_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isLightTheme(context)
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        appBar: CartWidgets.buildAppBar(context),
        body: BlocConsumer<CartBloc, CartState>(
          buildWhen: (previous, current) {
            return current is CartLoading || current is CartLoaded;
          },
          listener: (context, state) {
            if (state is CartItemDeleted) {
              CustomSnackbar.showCustomSnackBar(
                  appearFromTop: true, context, 'Item removed from cart');
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.products.isEmpty) {
                return CartWidgets.buildCartEmptyDisplay(context);
              }
              final cartItems = state.products;

              // Calculate subtotal, discount, and total for all products in the cart
              final subtotal = cartItems.fold(
                  0.0,
                  (sum, product) =>
                      sum + product.retailPrice * product.quantity);
              final discount = cartItems.fold(
                  0.0,
                  (sum, product) =>
                      sum +
                      ((product.retailPrice - product.offerPrice) *
                          product.quantity));
              final total = cartItems.fold(
                  0.0,
                  (sum, product) =>
                      sum + (product.offerPrice * product.quantity));
              log('TOTAL AMOUNT: ${total.toInt()}');

              return Stack(
                children: [
                  //! CART ITEMS CARD
                  FadeIn(
                      duration: const Duration(milliseconds: 100),
                      child: CartWidgets.buildCartItemsCard(cartItems)),
                  //! TOTAL CART ITEMS PRICE DETAILS CONTAINER
                  SlideInUp(
                    child: AnimatedCartItemsPriceDetailsContainer(
                        subtotal: subtotal, discount: discount, total: total),
                  )
                ],
              );
            }
            return const Center(child: SizedBox.shrink());
          },
        ));
  }
}
