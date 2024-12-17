import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/home/presentation/screens/image_viewer_screen.dart';
import 'package:wulflex/features/home/presentation/screens/size_chart_screen.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/custom_weightandsize_selector_container_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

PreferredSizeWidget buildAppBarWithIcons(
    BuildContext context, ProductModel product) {
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
                      color: isLightTheme(context)
                          ? AppColors.whiteThemeColor
                          : AppColors.blackThemeColor),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: isLightTheme(context)
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
                    color: isLightTheme(context)
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
                                      : isLightTheme(context)
                                          ? AppColors.blackThemeColor
                                          : AppColors.whiteThemeColor,
                                  size: 28,
                                )
                              : Icon(
                                  Icons.favorite_border_rounded,
                                  color: isLiked
                                      ? Colors.pinkAccent
                                      : isLightTheme(context)
                                          ? AppColors.blackThemeColor
                                          : AppColors.whiteThemeColor,
                                  size: 28,
                                );
                        },
                        circleColor: CircleColor(
                            start: isLightTheme(context)
                                ? AppColors.blackThemeColor
                                : AppColors.whiteThemeColor,
                            end: isLightTheme(context)
                                ? AppColors.blackThemeColor
                                : AppColors.whiteThemeColor),
                        bubblesColor: BubblesColor(
                            dotPrimaryColor: AppColors.blueThemeColor,
                            dotSecondaryColor: isLightTheme(context)
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
    width: MediaQuery.sizeOf(context).width,
    child: PageView.builder(
      controller: pageController,
      itemCount: product.imageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
              ScreenFullScreenImageViewer(imageUrls: product.imageUrls)),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 250,
                width: 250,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrls[index],
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress, // Shows the progress
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/wulflex_logo_nobg.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
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
  return IntrinsicWidth(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreyThemeColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ReviewError) {
            return Center(child: Text('Review Error'));
          } else if (state is ReviewsLoaded) {
            final enhancedReviews = state.reviews;
            if (enhancedReviews.isNotEmpty) {
              //! GETTING TOTAL RATINGS
              final double averageRating = enhancedReviews
                      .map((enhancedReview) => enhancedReview.review.rating)
                      .reduce((a, b) => a + b) /
                  enhancedReviews.length;
              // rounding off the total ratings
              final roundedRating =
                  double.parse(averageRating.toStringAsFixed(1));
              return Row(
                children: [
                  RatingBar(
                      itemSize: 19,
                      allowHalfRating: true,
                      initialRating: roundedRating,
                      ignoreGestures: true,
                      ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star_rounded,
                            color: AppColors.greenThemeColor,
                          ),
                          half: Icon(
                            Icons.star_half_rounded,
                            color: AppColors.greenThemeColor,
                          ),
                          empty: Icon(Icons.star_border_rounded,
                              color: AppColors.appBarLightGreyThemeColor)),
                      onRatingUpdate: (value) {}),
                  SizedBox(width: 8),
                  Text(
                    '4.0 Ratings',
                    style: AppTextStyles.viewProductratingsText,
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  RatingBar(
                      itemSize: 19,
                      allowHalfRating: true,
                      initialRating: 0,
                      ignoreGestures: true,
                      ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star_rounded,
                            color: AppColors.greenThemeColor,
                          ),
                          half: Icon(
                            Icons.star_half_rounded,
                            color: AppColors.greenThemeColor,
                          ),
                          empty: Icon(Icons.star_border_rounded,
                              color: AppColors.greyThemeColor)),
                      onRatingUpdate: (value) {}),
                  SizedBox(width: 8),
                  Text(
                    'No Ratings yet',
                    style: AppTextStyles.viewProductratingsText,
                  ),
                ],
              );
            }
          }
          return Text('Error: Try reloading the page');
        },
      ),
    ),
  );
}

Widget buildSizeAndSizeChartText(
    ProductModel productModel, BuildContext context) {
  return Visibility(
    visible: productModel.sizes.isNotEmpty,
    child: Row(
      children: [
        Text(
          'SIZE',
          style: AppTextStyles.viewProductTitleText(context),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => NavigationHelper.navigateToWithoutReplacement(
              context, ScreenSizeChart()),
          child: Row(
            children: [
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

Widget buildiWeightText(ProductModel productModel, BuildContext context) {
  return Visibility(
    visible: productModel.weights.isNotEmpty,
    child: Text(
      'WEIGHT',
      style: AppTextStyles.viewProductTitleText(context),
    ),
  );
}

Widget buildWeightSelectors(String? selectedWeight, ProductModel product,
    void Function(String) onSizeTapped) {
  return Visibility(
    visible: product.weights.isNotEmpty,
    child: Row(
      children: product.weights.reversed.map((weight) {
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

Widget buildDescriptionTitle(BuildContext context) {
  return Text("DESCRIPTION",
      style: AppTextStyles.viewProductTitleText(context));
}

Widget buildDescription(BuildContext context, bool isExpanded,
    ProductModel product, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
        textAlign: TextAlign.justify,
        style: AppTextStyles.descriptionText(context),
        overflow: TextOverflow.fade,
        maxLines: isExpanded ? null : 5,
        product.description),
  );
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
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      return GreenButtonWidget(
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

            context
                .read<CartBloc>()
                .add(AddToCartEvent(product: productToCart));
          },
          addIcon: true,
          icon: Icons.add_shopping_cart_rounded,
          buttonText: 'Add to cart',
          borderRadius: 25,
          width: 1,
          isLoading: state is CartLoading);
    },
  );
}

Widget customReviewProgressPercentageIndicator(BuildContext context,
    String leadingText, String trailingText, double progressValue) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(Icons.star_rounded, color: AppColors.greenThemeColor, size: 25),
      SizedBox(width: 3),
      Text(leadingText,
          style: AppTextStyles.linearProgressIndicatorLeadingText),
      SizedBox(width: 3.5),
      SizedBox(
        width: 130,
        child: LinearProgressIndicator(
          color: AppColors.greenThemeColor,
          backgroundColor: AppColors.appBarLightGreyThemeColor,
          borderRadius: BorderRadius.circular(10),
          minHeight: 10,
          value: progressValue,
        ),
      ),
      SizedBox(width: 3.5),
      Text(trailingText,
          style: AppTextStyles.linearProgressIndicatorTrailingText(context))
    ],
  );
}
