part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartItemQuantityLoading extends CartState {}

class CartSuccess extends CartState {}

class CartItemDeleted extends CartState {}

class CartError extends CartState {
  final String errorMessage;

  CartError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class CartLoaded extends CartState {
  final List<ProductModel> products;

  CartLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
