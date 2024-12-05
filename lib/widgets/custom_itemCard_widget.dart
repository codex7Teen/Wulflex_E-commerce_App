import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:wulflex/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/view_product_screen.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/navigation_helper_widget.dart';
import 'package:wulflex/widgets/theme_data_helper_widget.dart';

Widget buildItemCard(BuildContext context, ProductModel product) {
  final discountPercentage =
      (((product.retailPrice - product.offerPrice) / product.retailPrice) * 100)
          .round();

  return GestureDetector(
    onTap: () => NavigationHelper.navigateToWithoutReplacement(
        context, ScreenViewProducts(productModel: product)),
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(13),
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.sizeOf(context).width * 0.43,
          decoration: BoxDecoration(
            color: AppColors.lightGreyThemeColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      height: 150,
                      width: MediaQuery.sizeOf(context).width * 0.38,
                      child: Image.network(
                        product.imageUrls[0],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/wulflex_logo_nobg.png'),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                              child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null));
                        },
                      )),
                ),
              ),
              SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brandName,
                      style: AppTextStyles.itemCardBrandText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.name,
                      style: AppTextStyles.itemCardNameText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "₹${product.retailPrice.round()}",
                          style: AppTextStyles.itemCardSecondSubTitleText,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "₹${product.offerPrice.round()}",
                          style: AppTextStyles.itemCardSubTitleText,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? AppColors.whiteThemeColor
                            : const Color.fromARGB(255, 247, 247, 247),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Text("Save upto $discountPercentage%",
                          style: AppTextStyles.itemCardThirdSubTitleText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned Like Button
        Positioned(
          top: 0,
          right: 3.95,
          child: Container(
            padding: EdgeInsets.only(left: 7, right: 5, top: 11, bottom: 11),
            decoration: BoxDecoration(
                color: AppColors.greenThemeColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18))),
            child: Center(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final isFavorite = state is FavoriteLoaded
                      ? product.checkIsFavorite(state.favorites)
                      : false;
                  return LikeButton(
                    isLiked: isFavorite,
                    onTap: (isLiked) async {
                      if (isLiked) {
                        context.read<FavoriteBloc>().add(
                            RemoveFromFavoritesEvent(
                                product.id!, product.brandName));
                      } else {
                        context
                            .read<FavoriteBloc>()
                            .add(AddToFavoritesEvent(product));
                      }
                      return !isLiked;
                    },
                    likeBuilder: (isLiked) {
                      return isLiked
                          ? Icon(
                              Icons.favorite_rounded,
                              color: Colors.pinkAccent,
                              size: 21.6,
                            )
                          : Icon(
                              Icons.favorite_border_rounded,
                              color: AppColors.whiteThemeColor,
                              size: 21.6,
                            );
                    },
                    circleColor: CircleColor(
                        start: AppColors.blackThemeColor,
                        end: AppColors.blackThemeColor),
                    bubblesColor: BubblesColor(
                        dotPrimaryColor: AppColors.blueThemeColor,
                        dotSecondaryColor: AppColors.blackThemeColor),
                    size: 21.6,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
