import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_itemCard_widget.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/favorite_lottie.json',
                  fit: BoxFit.cover, width: 50),
              Text('FAVORITES', style: AppTextStyles.appbarTextBig(context)),
              Lottie.asset('assets/lottie/favorite_lottie.json',
                  fit: BoxFit.cover, width: 50),
            ],
          ),
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
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 7.5,
                        childAspectRatio: 0.604),
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
