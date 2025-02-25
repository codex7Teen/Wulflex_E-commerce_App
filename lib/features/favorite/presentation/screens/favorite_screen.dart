import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/favorite/presentation/widgets/favorite_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenFavorite extends StatelessWidget {
  const ScreenFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isLightTheme(context)
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        appBar: FavoriteScreenWidgets.buildAppbar(context),
        body: Padding(
          padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
          child: BlocConsumer<FavoriteBloc, FavoriteState>(
            listener: (context, state) {
              if (state is FavoriteLoaded && state.removedProductName != null) {
                CustomSnackbar.showCustomSnackBar(
                    appearFromTop: true,
                    context,
                    '${state.removedProductName} removed from favorites!');
              }
            },
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavoriteError) {
                return Center(
                    child: Text('Error loading favorites: ${state.error}'));
              } else if (state is FavoriteLoaded) {
                // check if favorites list is empty
                if (state.favorites.isEmpty) {
                  //! FAVORITES EMPTY
                  return FavoriteScreenWidgets.buildEmptyFavoritesDisplay(context);
                } else {
                  //! FAVORITE ITEM CARDS
                  return SlideInDown(
                      child:
                          FavoriteScreenWidgets.buildItemCards(context, state));
                }
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            },
          ),
        ));
  }
}
