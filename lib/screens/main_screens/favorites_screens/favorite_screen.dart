import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_itemCard_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

class ScreenFavorite extends StatelessWidget {
  const ScreenFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isLightTheme(context)
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('FAVORITES', style: AppTextStyles.appbarTextBig(context)),
        ),
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavoriteError) {
                return Center(
                    child: Text('Error loading favorites: ${state.error}'));
              } else if (state is FavoriteLoaded) {
                // check if favorites list is empty
                if (state.favorites.isEmpty) {
                  return Center(
                    child: Text(
                        'Add somethig to favorites : TODO Design a add favorites lottie here'),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 7.5,
                        childAspectRatio: 0.63),
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) {
                      return buildItemCard(context, state.favorites[index]);
                    },
                  );
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
