import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/shared/widgets/custom_itemCard_widget.dart';

class FavoriteScreenWidgets {
  static PreferredSizeWidget buildAppbar(BuildContext context) {
    return AppBar(
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
    );
  }

  static Widget buildItemCards(BuildContext context, FavoriteLoaded state) {
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
