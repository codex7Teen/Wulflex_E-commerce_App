part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

//! LOAD FAVORITES EVENT
class LoadFavoritesEvent extends FavoriteEvent {}

//! ADD TO FAVORITE EVENT
class AddToFavoritesEvent extends FavoriteEvent {
  final ProductModel product;

  const AddToFavoritesEvent(this.product);
  @override
  List<Object> get props => [product];
}

//! REMOVE FROM FAVORITE EVENT
class RemoveFromFavoritesEvent extends FavoriteEvent {
  final String productId;

  const RemoveFromFavoritesEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
