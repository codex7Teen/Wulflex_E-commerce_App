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
