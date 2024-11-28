part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

//! FAVORITES LOADING STATE
class FavoriteLoading extends FavoriteState {}

//! FAVORITES LOADED STATE
class FavoriteLoaded extends FavoriteState {
  final List<ProductModel> favorites;

  const FavoriteLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

//! FAVORITES ERROR STATE
class FavoriteError extends FavoriteState {
  final String error;

  const FavoriteError(this.error);

  @override
  List<Object> get props => [error];
}
