part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

//! ADD TO CART EVENT
class AddToCartEvent extends CartEvent {
  final ProductModel product;

  AddToCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

//! FETCH CART EVENT
class FetchCartEvent extends CartEvent {}

//! REMOVE FROM CART EVENT
class RemoveFromCartEvent extends CartEvent {
  final String productId;

  RemoveFromCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

//! CLEAR ALL CART ITEMS
class ClearAllCartItemsEvent extends CartEvent {}

//! UPDATE CART ITEM QUANTITY EVENT
class UpdateCartItemQuantityEvent extends CartEvent {
  final String productId;
  final int quantity;

  UpdateCartItemQuantityEvent(
      {required this.productId, required this.quantity});

  @override
  List<Object> get props => [productId, quantity];
}