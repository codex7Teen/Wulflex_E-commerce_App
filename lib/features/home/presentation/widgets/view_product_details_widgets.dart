import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/data/models/enhanced_review_model.dart';
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

class ViewProductDetailsWidgets {
  static PreferredSizeWidget buildAppBarWithIcons(
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
                        return SlideInDown(
                          child: LikeButton(
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
                          ),
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

  static Widget buildItemImageSlider(BuildContext context,
      PageController pageController, ProductModel product) {
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
                          value:
                              downloadProgress.progress, // Shows the progress
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

  static Widget buildPageIndicator(PageController pageController,
      BuildContext context, ProductModel product) {
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

  static Widget buildProductHeadingText(
      BuildContext context, ProductModel product) {
    return Text("${product.brandName} ${product.name}",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.viewProductMainHeading(context));
  }

  static Widget buildRatingsContainer() {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyThemeColor),
          borderRadius: BorderRadius.circular(25),
        ),
        child: BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            if (state is ReviewLoading) {
              return ViewProductDetailsWidgets.buildRatingsShimmer(context);
            } else if (state is ReviewError) {
              return const Center(child: Text('Review Error'));
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
                            full: const Icon(
                              Icons.star_rounded,
                              color: AppColors.greenThemeColor,
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: AppColors.greenThemeColor,
                            ),
                            empty: const Icon(Icons.star_border_rounded,
                                color: AppColors.appBarLightGreyThemeColor)),
                        onRatingUpdate: (value) {}),
                    const SizedBox(width: 8),
                    Text(
                      '$roundedRating Ratings',
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
                            full: const Icon(
                              Icons.star_rounded,
                              color: AppColors.greenThemeColor,
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: AppColors.greenThemeColor,
                            ),
                            empty: const Icon(Icons.star_border_rounded,
                                color: AppColors.greyThemeColor)),
                        onRatingUpdate: (value) {}),
                    const SizedBox(width: 8),
                    Text(
                      'No Ratings yet',
                      style: AppTextStyles.viewProductratingsText,
                    ),
                  ],
                );
              }
            }
            return const Text('Error: Try reloading the page');
          },
        ),
      ),
    );
  }

  static Widget buildSizeAndSizeChartText(
      ProductModel productModel, BuildContext context) {
    return Visibility(
      visible: productModel.sizes.isNotEmpty,
      child: Row(
        children: [
          Text(
            'SIZE',
            style: AppTextStyles.viewProductTitleText(context),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => NavigationHelper.navigateToWithoutReplacement(
                context, const ScreenSizeChart()),
            child: Row(
              children: [
                const Icon(
                  Icons.straighten_outlined,
                  color: AppColors.greenThemeColor,
                ),
                const SizedBox(width: 6),
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

  static Widget buildSizeSelectors(String? selectedSize, ProductModel product,
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

  static Widget buildiWeightText(
      ProductModel productModel, BuildContext context) {
    return Visibility(
      visible: productModel.weights.isNotEmpty,
      child: Text(
        'WEIGHT',
        style: AppTextStyles.viewProductTitleText(context),
      ),
    );
  }

  static Widget buildWeightSelectors(String? selectedWeight,
      ProductModel product, void Function(String) onSizeTapped) {
    // Create a sorted copy of the weights list
    final sortedWeights = List<String>.from(product.weights)
      ..sort((a, b) {
        // Extract numbers from strings (removing 'KG' and converting to double)
        double weightA = double.parse(a.replaceAll(' KG', ''));
        double weightB = double.parse(b.replaceAll(' KG', ''));
        return weightA.compareTo(weightB);
      });

    return Visibility(
      visible: product.weights.isNotEmpty,
      child: Row(
        children: sortedWeights.map((weight) {
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

  static Widget buildDescriptionTitle(BuildContext context) {
    return Text("DESCRIPTION",
        style: AppTextStyles.viewProductTitleText(context));
  }

  static Widget buildDescription(BuildContext context, bool isExpanded,
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

  static Widget buildReammoreAndReadlessButton(
      bool isExpanded, VoidCallback onTap, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
          alignment: Alignment.topRight,
          child: Text(isExpanded ? "Read Less" : "Read more",
              style: AppTextStyles.readmoreAndreadLessText(context))),
    );
  }

  static Widget buildAddToCartButton(BuildContext context, ProductModel product,
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

  static Widget customReviewProgressPercentageIndicator(BuildContext context,
      String leadingText, String trailingText, double progressValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.star_rounded,
            color: AppColors.greenThemeColor, size: 25),
        const SizedBox(width: 3),
        Text(leadingText,
            style: AppTextStyles.linearProgressIndicatorLeadingText),
        const SizedBox(width: 3.5),
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
        const SizedBox(width: 3.5),
        Text(trailingText,
            style: AppTextStyles.linearProgressIndicatorTrailingText(context))
      ],
    );
  }

  static Widget buildRatingAndReviewsHeading(BuildContext context) {
    return Text("RATINGS & REVIEWS",
        style: AppTextStyles.viewProductTitleText(context));
  }

  static Widget buildReviewMetrics(
      BuildContext context,
      double roundedRating,
      List<EnhancedReviewModel> enhancedReviews,
      String roundedPercentageOfFiveStar,
      String roundedPercentageOfFourStar,
      String roundedPercentageOfThreeStar,
      String roundedPercentageOfTwoStar,
      String roundedPercentageOfOneStar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(roundedRating.toString(),
                  style: AppTextStyles.viewRatingBigRatingText),
              const SizedBox(height: 1.5),
              RatingBar(
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemSize: 24,
                  allowHalfRating: true,
                  initialRating: roundedRating,
                  ignoreGestures: true,
                  ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star_rounded,
                        color: AppColors.greenThemeColor,
                      ),
                      half: const Icon(
                        Icons.star_half_rounded,
                        color: AppColors.greenThemeColor,
                      ),
                      empty: const Icon(Icons.star_border_rounded,
                          color: AppColors.appBarLightGreyThemeColor)),
                  onRatingUpdate: (value) {}),
              const SizedBox(height: 6),
              Text(
                '${enhancedReviews.length} REVIEWS',
                style: AppTextStyles.buildTotalReviewsText(context),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewProductDetailsWidgets.customReviewProgressPercentageIndicator(
                context,
                '5',
                roundedPercentageOfFiveStar,
                convertPercentageToDecimal(roundedPercentageOfFiveStar)),
            ViewProductDetailsWidgets.customReviewProgressPercentageIndicator(
                context,
                '4',
                roundedPercentageOfFourStar,
                convertPercentageToDecimal(roundedPercentageOfFourStar)),
            ViewProductDetailsWidgets.customReviewProgressPercentageIndicator(
                context,
                '3',
                roundedPercentageOfThreeStar,
                convertPercentageToDecimal(roundedPercentageOfThreeStar)),
            ViewProductDetailsWidgets.customReviewProgressPercentageIndicator(
                context,
                '2',
                roundedPercentageOfTwoStar,
                convertPercentageToDecimal(roundedPercentageOfTwoStar)),
            ViewProductDetailsWidgets.customReviewProgressPercentageIndicator(
                context,
                '1',
                roundedPercentageOfOneStar,
                convertPercentageToDecimal(roundedPercentageOfOneStar)),
          ],
        )
      ],
    );
  }

  //! Function to convert the percentage string to a decimal value
  static double convertPercentageToDecimal(String percentageString) {
    // Remove the '%' sign and convert to double
    double percentage = double.parse(percentageString.replaceAll('%', ''));
    // convert to a value between 0 and 1
    return percentage / 100.0;
  }

  static Widget buildEmptyReviewsDisplay(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/no_reviews_lottie.json', width: 200),
          Text(
            'No reviews yet. Check back later\nfor customer insights.',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptySectionText(context),
          )
        ],
      ),
    );
  }

  static Widget buildCustomerReviews(
      BuildContext context, List<EnhancedReviewModel> enhancedReviews) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: enhancedReviews.length,
      itemBuilder: (context, index) {
        final reviews = enhancedReviews[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              color: AppColors.whiteThemeColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.appBarLightGreyThemeColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  reviews.userImageUrl != null
                      ?
                      // User image
                      SizedBox(
                          height: 46,
                          width: 46,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: reviews.userImageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Image.asset(
                                    'assets/wulflex_logo_nobg.png');
                              },
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 28,
                          width: 28,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child:
                                  Image.asset('assets/wulflex_logo_nobg.png')),
                        ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Username and date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(reviews.userName,
                                style: AppTextStyles.reviewUsernameText),
                            Text(
                                DateFormat('MMMM d yyyy')
                                    .format(reviews.review.createdAt),
                                style: AppTextStyles.reviewDateText)
                          ],
                        ),
                        // ratings section
                        Row(
                          children: [
                            Text(
                              reviews.review.rating.round().toString(),
                              style: AppTextStyles
                                  .linearProgressIndicatorLeadingText,
                            ),
                            const SizedBox(width: 3),
                            RatingBar(
                                itemSize: 17,
                                allowHalfRating: true,
                                initialRating: reviews.review.rating,
                                ignoreGestures: true,
                                ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.greenThemeColor,
                                    ),
                                    half: const Icon(
                                      Icons.star_half_rounded,
                                      color: AppColors.greenThemeColor,
                                    ),
                                    empty: const Icon(Icons.star_border_rounded,
                                        color: AppColors
                                            .appBarLightGreyThemeColor)),
                                onRatingUpdate: (value) {}),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                  visible: reviews.review.selectedSizeOrWeight.isNotEmpty,
                  child: const SizedBox(height: 9)),
              Visibility(
                visible: reviews.review.selectedSizeOrWeight.isNotEmpty,
                child: Text(
                    reviews.review.selectedSizeOrWeight.contains('KG')
                        ? 'Ordered weight: ${reviews.review.selectedSizeOrWeight}'
                        : 'Ordered size: ${reviews.review.selectedSizeOrWeight}',
                    style: AppTextStyles.reviewOrderdSizeorweightText),
              ),
              Visibility(
                  visible: reviews.review.tags.isNotEmpty,
                  child: const SizedBox(height: 11)),
              //! Display review tags
              Visibility(
                visible: reviews.review.tags.isNotEmpty,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: reviews.review.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyThemeColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.sell_rounded,
                              size: 13.5, color: AppColors.darkishGrey),
                          const SizedBox(width: 5),
                          Text(
                            tag,
                            style: AppTextStyles.rateScreenSupermini(context)
                                .copyWith(color: AppColors.blackThemeColor),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                  visible: reviews.review.reviewText.isNotEmpty,
                  child: const SizedBox(height: 12)),
              Visibility(
                  visible: reviews.review.reviewText.isNotEmpty,
                  child: Text(
                    " \"${reviews.review.reviewText}\" ",
                    style: AppTextStyles.descriptionText(context,
                        neverChangeColor: true),
                  ))
            ],
          ),
        );
      },
    );
  }

  static Widget buildRatingsShimmer(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyThemeColor),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Shimmer.fromColors(
          baseColor:
              isLightTheme(context) ? Colors.grey[300]! : Colors.grey[800]!,
          highlightColor:
              isLightTheme(context) ? Colors.grey[100]! : Colors.grey[700]!,
          child: Row(
            children: [
              // Shimmer for rating stars
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Container(
                      width: 19,
                      height: 19,
                      decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? Colors.white
                            : Colors.grey[600],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Shimmer for rating text
              Container(
                width: 80,
                height: 16,
                decoration: BoxDecoration(
                  color:
                      isLightTheme(context) ? Colors.white : Colors.grey[600],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildReviewMetricsShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isLightTheme(context) ? Colors.grey[300]! : Colors.grey[800]!,
      highlightColor:
          isLightTheme(context) ? Colors.grey[100]! : Colors.grey[700]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Rating and stars
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rating number
                Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        isLightTheme(context) ? Colors.white : Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 1.5),
                // Stars
                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isLightTheme(context)
                              ? Colors.white
                              : Colors.grey[600],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Review count
                Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                    color:
                        isLightTheme(context) ? Colors.white : Colors.grey[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          // Right side - Progress bars
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    // Star number
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? Colors.white
                            : Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Progress bar
                    Container(
                      width: 120,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? Colors.white
                            : Colors.grey[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Percentage
                    Container(
                      width: 40,
                      height: 15,
                      decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? Colors.white
                            : Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildCustomerReviewsShimmer(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3, // Show 3 shimmer review cards
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteThemeColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.appBarLightGreyThemeColor),
        ),
        child: Shimmer.fromColors(
          baseColor:
              isLightTheme(context) ? Colors.grey[300]! : Colors.grey[800]!,
          highlightColor:
              isLightTheme(context) ? Colors.grey[100]! : Colors.grey[700]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // User image
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? Colors.white
                          : Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Username and date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 16,
                              decoration: BoxDecoration(
                                color: isLightTheme(context)
                                    ? Colors.white
                                    : Colors.grey[600],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 80,
                              height: 14,
                              decoration: BoxDecoration(
                                color: isLightTheme(context)
                                    ? Colors.white
                                    : Colors.grey[600],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        // Rating
                        Row(
                          children: List.generate(
                            5,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  color: isLightTheme(context)
                                      ? Colors.white
                                      : Colors.grey[600],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Size/Weight info
              Container(
                width: 150,
                height: 14,
                decoration: BoxDecoration(
                  color:
                      isLightTheme(context) ? Colors.white : Colors.grey[600],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              // Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: 80,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? Colors.white
                          : Colors.grey[600],
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Review text
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color:
                      isLightTheme(context) ? Colors.white : Colors.grey[600],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
