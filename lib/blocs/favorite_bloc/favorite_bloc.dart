import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/services/favorite_services.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteServices _favoritesService;

  FavoriteBloc(this._favoritesService) : super(FavoriteInitial()) {
    //! LOAD FAVORITES BLOC
    on<LoadFavoritesEvent>((event, emit) async {
      emit(FavoriteLoading());
      try {
        final favorites = await _favoritesService.getUserFavorites();
        emit(FavoriteLoaded(favorites));
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });

    //! ADD TO FAVORITES BLOC
    on<AddToFavoritesEvent>((event, emit) async {
      try {
        // Update the product's favorite status
        final updatedProduct = event.product.copyWith(isFavorite: true);
        await _favoritesService.addFavorite(updatedProduct);

        final favorites = await _favoritesService.getUserFavorites();
        emit(FavoriteLoaded(favorites));
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });

    //! REMOVE FROM FAVORITES BLOC
    on<RemoveFromFavoritesEvent>((event, emit) async {
      try {
        await _favoritesService.removeFavorite(event.productId);

        final favorites = await _favoritesService.getUserFavorites();
        emit(FavoriteLoaded(favorites, removedProductName: event.productName));
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });
  }
}
