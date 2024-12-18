import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/home/presentation/screens/view_product_details_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

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
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrls[0],
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return SizedBox(
                              width: 16,
                              height: 16,
                              child:
                                  Image.asset('assets/wulflex_logo_nobg.png'));
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "₹${product.retailPrice.round()}",
                          style:
                              AppTextStyles.itemCardSecondSubTitleText.copyWith(
                            decoration: TextDecoration
                                .lineThrough, // Add strikethrough to retail price
                            color: Colors
                                .grey, // Optional: make retail price appear less prominent
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 5), // Reduced spacing
                        Text(
                          "₹${product.offerPrice.round()}",
                          style: AppTextStyles.itemCardSubTitleText,
                          overflow: TextOverflow.ellipsis,
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
