import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/blocs/cart_bloc/cart_bloc.dart';
import 'package:wulflex/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_green_button_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/widgets/custom_weightandsize_selector_container_widget.dart';

PreferredSizeWidget buildAppBarWithIcons(
    BuildContext context, ProductModel product) {
  final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    actions: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLightTheme
                          ? AppColors.whiteThemeColor
                          : AppColors.blackThemeColor),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: isLightTheme
                          ? AppColors.blackThemeColor
                          : AppColors.whiteThemeColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLightTheme
                        ? AppColors.whiteThemeColor
                        : AppColors.blackThemeColor),
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
                                  Icons.favorite,
                                  color: isLiked
                                      ? Colors.pinkAccent
                                      : isLightTheme
                                          ? AppColors.blackThemeColor
                                          : AppColors.whiteThemeColor,
                                  size: 28,
                                )
                              : Icon(
                                  Icons.favorite_border_rounded,
                                  color: isLiked
                                      ? Colors.pinkAccent
                                      : isLightTheme
                                          ? AppColors.blackThemeColor
                                          : AppColors.whiteThemeColor,
                                  size: 28,
                                );
                        },
                        circleColor: CircleColor(
                            start: isLightTheme
                                ? AppColors.blackThemeColor
                                : AppColors.whiteThemeColor,
                            end: isLightTheme
                                ? AppColors.blackThemeColor
                                : AppColors.whiteThemeColor),
                        bubblesColor: BubblesColor(
                            dotPrimaryColor: AppColors.blueThemeColor,
                            dotSecondaryColor: isLightTheme
                                ? AppColors.blackThemeColor
                                : AppColors.whiteThemeColor),
                        size: 28,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildItemImageSlider(
    BuildContext context, PageController pageController, ProductModel product) {
  return SizedBox(
      height: 300,
      width: MediaQuery.sizeOf(context).width * 1,
      child: PageView.builder(
        controller: pageController,
        itemCount: product.imageUrls.length,
        itemBuilder: (context, index) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 250,
                width: 250,
                child: ClipRRect(
                    child: Image.network(
                  product.imageUrls[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/wulflex_logo_nobg.png',
                    fit: BoxFit.contain,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    // show image loading indicator
                    return Center(
                        child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null));
                  },
                )),
              ),
            ),
          );
        },
      ));
}

Widget buildPageIndicator(
    PageController pageController, BuildContext context, ProductModel product) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;
  return SmoothPageIndicator(
    controller: pageController,
    count: product.imageUrls.length,
    effect: ExpandingDotsEffect(
        activeDotColor: AppColors.greenThemeColor,
        dotColor: isLightTheme
            ? AppColors.whiteThemeColor
            : AppColors.blackThemeColor,
        dotHeight: 8,
        dotWidth: 8),
  );
}

Widget buildProductHeadingText(BuildContext context, ProductModel product) {
  return Text("${product.brandName} ${product.name}",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.viewProductMainHeading(context));
}

Widget buildRatingsContainer() {
  return Container(
    width: 198,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.lightGreyThemeColor),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: [
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.greenThemeColor, size: 20),
        Icon(Icons.star_rate, color: AppColors.lightGreyThemeColor, size: 20),
        SizedBox(width: 8),
        Text(
          '4.0 Ratings',
          style: AppTextStyles.viewProductratingsText,
        ),
      ],
    ),
  );
}

Widget buildSizeAndSizeChartText(ProductModel productModel) {
  return Visibility(
    visible: productModel.sizes.isNotEmpty,
    child: Row(
      children: [
        Text(
          'SIZE',
          style: AppTextStyles.viewProductTitleText,
        ),
        Spacer(),
        Icon(
          Icons.straighten_outlined,
          color: AppColors.greenThemeColor,
        ),
        SizedBox(width: 6),
        Text(
          'Size Chart',
          style: AppTextStyles.sizeChartText,
        ),
      ],
    ),
  );
}

Widget buildSizeSelectors(String? selectedSize, ProductModel product,
    void Function(String) onSizeTapped) {
  return Visibility(
    visible: product.sizes.isNotEmpty,
    child: Row(
      children: product.sizes.map((size) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomWeightandsizeSelectorContainerWidget(
            weightOrSize: size,
            isSelected: selectedSize == size,
            onTap: () => onSizeTapped(size),
          ),
        );
      }).toList(),
    ),
  );
}

Widget buildiWeightText(ProductModel productModel) {
  return Visibility(
    visible: productModel.weights.isNotEmpty,
    child: Text(
      'WEIGHT',
      style: AppTextStyles.viewProductTitleText,
    ),
  );
}

Widget buildWeightSelectors(String? selectedWeight, ProductModel product,
    void Function(String) onSizeTapped) {
  return Visibility(
    visible: product.weights.isNotEmpty,
    child: Row(
      children: product.weights.map((weight) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomWeightandsizeSelectorContainerWidget(
            weightOrSize: weight,
            isSelected: selectedWeight == weight,
            onTap: () => onSizeTapped(weight),
          ),
        );
      }).toList(),
    ),
  );
}

Widget buildPriceDetailsContainer(BuildContext context, ProductModel product) {
  final isLightTheme = Theme.of(context).brightness == Brightness.light;

  // Calculating discount percentage
  final discountPercentage =
      ((product.retailPrice - product.offerPrice) / product.retailPrice) * 100;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isLightTheme
            ? AppColors.lightGreyThemeColor
            : AppColors.whiteThemeColor),
    child: Row(
      children: [
        Text(
          "₹ ${product.offerPrice}",
          style: AppTextStyles.offerPriceHeadingText,
        ),
        SizedBox(width: 14),
        Text(
          "₹ ${product.retailPrice}",
          style: AppTextStyles.originalPriceText,
        ),
        SizedBox(width: 16),
        Text(
          "${discountPercentage.toStringAsFixed(0)}% OFF",
          style: AppTextStyles.offerPercentageText,
        ),
        Spacer(),
        Icon(
          Icons.info,
          color: AppColors.darkishGrey,
        )
      ],
    ),
  );
}

Widget buildDescriptionTitle() {
  return Text("DESCRIPTION", style: AppTextStyles.viewProductTitleText);
}

Widget buildDescription(
    BuildContext context, bool isExpanded, ProductModel product) {
  return Text(
      textAlign: TextAlign.justify,
      style: AppTextStyles.descriptionText(context),
      overflow: TextOverflow.fade,
      maxLines: isExpanded ? null : 5,
      product.description);
}

Widget buildReammoreAndReadlessButton(
    bool isExpanded, VoidCallback onTap, BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: Align(
        alignment: Alignment.topRight,
        child: Text(isExpanded ? "Read Less" : "Read more",
            style: AppTextStyles.readmoreAndreadLessText(context))),
  );
}

Widget buildAddToCartButton(BuildContext context, ProductModel product,
    String? selectedWeight, String? selectedSize) {
  return GestureDetector(
    onTap: () {
      if ((product.weights.isNotEmpty && selectedWeight == null) ||
          (product.sizes.isNotEmpty && selectedSize == null)) {
        CustomSnackbar.showCustomSnackBar(
            context,
            product.weights.isNotEmpty
                ? 'Please select product weight'
                : 'Please select product size',
            icon: Icons.error);
        return;
      }
      // create a new product with selected size or weight
      final productToCart = product.copyWith(
          selectedWeight: selectedWeight, selectedSize: selectedSize);

      context.read<CartBloc>().add(AddToCartEvent(product: productToCart));
    },
    child: BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return GreenButtonWidget(
            buttonText: 'Add to cart',
            borderRadius: 25,
            width: 1,
            isLoading: state is CartLoading);
      },
    ),
  );
}
