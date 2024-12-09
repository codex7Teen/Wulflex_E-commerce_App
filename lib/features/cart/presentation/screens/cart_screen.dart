import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/cart/presentation/widgets/cart_widgets.dart';
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
          listener: (context, state) {
            if (state is CartItemDeleted) {
              CustomSnackbar.showCustomSnackBar(
                  appearFromTop: true, context, 'Item removed from cart');
              // context.read<CartBloc>().add(FetchCartEvent());
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(
                      'Please add product to cart. TODOD IMPLEMENT A LOTTIE HERE'),
                );
              }
              final cartItems = state.products;

              // Calculate subtotal, discount, and total for all products in the cart
              final subtotal = cartItems.fold(
                  0.0, (sum, product) => sum + product.retailPrice);
              final discount = cartItems.fold(
                  0.0,
                  (sum, product) =>
                      sum + (product.retailPrice - product.offerPrice));
              final total = cartItems.fold(
                  0.0, (sum, product) => sum + product.offerPrice);

              return Stack(
                children: [
                  CartWidgets.buildCartItemsCard(cartItems),
                  CartWidgets.buildBottomPricedetailAndCheckoutContainer(
                      context, subtotal, discount, total)
                ],
              );
            }
            return Center(child: SizedBox.shrink());
          },
        ));
  }
}
