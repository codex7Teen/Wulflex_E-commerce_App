import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/services/cart_services.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartServices _cartServices;
  CartBloc(this._cartServices) : super(CartInitial()) {
    //! ADD TO CART BLOC
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await _cartServices.addToCart(event.product);
        final updatedCartItems = await _cartServices.fetchCartItems();
        emit(CartSuccess());
        emit(CartLoaded(products: updatedCartItems));
        log('ITEM ADDED TO CART');
      } catch (error) {
        emit(CartError(errorMessage: error.toString()));
      }
    });

    //! FETCH CART ITEMS
    on<FetchCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final cartItems = await _cartServices.fetchCartItems();
        emit(CartLoaded(products: cartItems));
      } catch (error) {
        CartError(errorMessage: error.toString());
      }
    });

    //! REMOVE FROM CART EVENT
    on<RemoveFromCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await _cartServices.removeFromCart(event.productId);
        final updatedCartItems = await _cartServices.fetchCartItems();
        emit(CartLoaded(products: updatedCartItems));
        log('ITEM REMOVED FROM CART');
      } catch (error) {
        emit(CartError(errorMessage: error.toString()));
      }
    });
  }
}
