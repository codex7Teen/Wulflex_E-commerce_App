import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/models/enhanced_review_model.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/home/presentation/widgets/view_product_details_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/animated_price_details_container.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';

class ScreenViewProducts extends StatefulWidget {
  final ProductModel productModel;
  const ScreenViewProducts({super.key, required this.productModel});

  @override
  State<ScreenViewProducts> createState() => _ScreenViewProductsState();
}

class _ScreenViewProductsState extends State<ScreenViewProducts> {
  // Track selected size (only one can be selected)
  String? selectedSize;
  // Track selected weight (only one can be selected)
  String? selectedWeight;

  void updateSelectedSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  void updateSelectedWeight(String weight) {
    setState(() {
      selectedWeight = weight;
    });
  }

  // Track expand or collapse of the description
  bool isExpanded = false;

  @override
  void initState() {
    context.read<FavoriteBloc>().add(LoadFavoritesEvent());
    context
        .read<ReviewBloc>()
        .add(FetchProductReviewsEvent(productId: widget.productModel.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: AppColors.lightGreyThemeColor,
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            CustomSnackbar.showCustomSnackBar(
                appearFromTop: true, context, 'Item added to cart... 🎉🎉🎉');
          }
        },
        child: CustomScrollView(
          slivers: [
            //! A P P - B A R
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              pinned: false,
              expandedHeight: 50.0,
              flexibleSpace: FlexibleSpaceBar(
                background: ViewProductDetailsWidgets.buildAppBarWithIcons(
                    context, widget.productModel),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  //! ITEM IMAGE WITH SLIDER (PAGEVIEW)
                  ZoomIn(
                    child: ViewProductDetailsWidgets.buildItemImageSlider(
                        context, pageController, widget.productModel),
                  ),
                  const SizedBox(height: 4),
                  ViewProductDetailsWidgets.buildPageIndicator(
                      pageController, context, widget.productModel),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: isLightTheme
                            ? AppColors.whiteThemeColor
                            : AppColors.blackThemeColor),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          //! PRODUCT NAME HEADING
                          FadeInLeft(
                            child: ViewProductDetailsWidgets
                                .buildProductHeadingText(
                                    context, widget.productModel),
                          ),
                          const SizedBox(height: 14),
                          //! RATINGS STARS
                          ViewProductDetailsWidgets.buildRatingsContainer(),
                          const SizedBox(height: 20),
                          //! SIZECHART TEXT
                          ViewProductDetailsWidgets.buildSizeAndSizeChartText(
                              widget.productModel, context),
                          Visibility(
                              visible: widget.productModel.sizes.isNotEmpty,
                              child: const SizedBox(height: 8)),
                          //! SIZE SELECTORS
                          ViewProductDetailsWidgets.buildSizeSelectors(
                              selectedSize,
                              widget.productModel,
                              (size) => updateSelectedSize(size)),
                          //! WEIGHT TEXT
                          ViewProductDetailsWidgets.buildiWeightText(
                              widget.productModel, context),
                          Visibility(
                              visible: widget.productModel.weights.isNotEmpty,
                              child: const SizedBox(height: 8)),
                          //! WEIGHT SELECTORS
                          ViewProductDetailsWidgets.buildWeightSelectors(
                              selectedWeight,
                              widget.productModel,
                              (weight) => updateSelectedWeight(weight)),
                          const SizedBox(height: 24),
                          //! PRICE CONTAINER
                          AnimatedPriceContainer(product: widget.productModel),
                          const SizedBox(height: 24),
                          //! PRODUCT DESCRIPTION TITLE
                          ViewProductDetailsWidgets.buildDescriptionTitle(
                              context),
                          const SizedBox(height: 6),
                          //! PRODUCT DESCRIPTION
                          ViewProductDetailsWidgets.buildDescription(
                              context,
                              isExpanded,
                              widget.productModel,
                              () => setState(() {
                                    isExpanded = !isExpanded;
                                  })),
                          ViewProductDetailsWidgets
                              .buildReammoreAndReadlessButton(
                                  isExpanded,
                                  () => setState(() {
                                        isExpanded = !isExpanded;
                                      }),
                                  context),
                          const SizedBox(height: 24),
                          //! ADD TO CART BUTTON
                          ViewProductDetailsWidgets.buildAddToCartButton(
                              context,
                              widget.productModel,
                              selectedWeight,
                              selectedSize),
                          const SizedBox(height: 24),
                          //! RATINGS & REVIEW HEADING
                          ViewProductDetailsWidgets
                              .buildRatingAndReviewsHeading(context),
                          const SizedBox(height: 6),
                          BlocBuilder<ReviewBloc, ReviewState>(
                              builder: (context, state) {
                            if (state is ReviewLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is ReviewError) {
                              return const Center(
                                  child: Text('Failed to load reviews.'));
                            } else if (state is ReviewsLoaded) {
                              //! Sort reviews by date in descendin order (latest first)
                              final enhancedReviews =
                                  List<EnhancedReviewModel>.from(state.reviews)
                                    ..sort((a, b) => b.review.createdAt
                                        .compareTo(a.review.createdAt));
                              if (enhancedReviews.isNotEmpty) {
                                //! GETTING TOTAL RATINGS
                                final double averageRating = enhancedReviews
                                        .map((enhancedReview) =>
                                            enhancedReview.review.rating)
                                        .reduce((a, b) => a + b) /
                                    enhancedReviews.length;
                                // rounding off the total ratings
                                final roundedRating = double.parse(
                                    averageRating.toStringAsFixed(1));

                                //! GETTING THE PERCENTAGE OF STARS
                                // Count number of ratings in each range
                                int countOfOnestar = 0;
                                int countOfTwostar = 0;
                                int countOfThreestar = 0;
                                int countOfFourstar = 0;
                                int countOfFiveStar = 0;

                                for (var enhancedReview in enhancedReviews) {
                                  if (enhancedReview.review.rating >= 1.0 &&
                                      enhancedReview.review.rating <= 1.9) {
                                    countOfOnestar++;
                                  } else if (enhancedReview.review.rating >=
                                          2.0 &&
                                      enhancedReview.review.rating <= 2.9) {
                                    countOfTwostar++;
                                  } else if (enhancedReview.review.rating >=
                                          3.0 &&
                                      enhancedReview.review.rating <= 3.9) {
                                    countOfThreestar++;
                                  } else if (enhancedReview.review.rating >=
                                          4.0 &&
                                      enhancedReview.review.rating <= 4.9) {
                                    countOfFourstar++;
                                  } else if (enhancedReview.review.rating ==
                                      5.0) {
                                    countOfFiveStar++;
                                  }
                                }
                                // Calculate the percentages
                                final totalReviews = enhancedReviews.length;
                                final percentageOfOnestar =
                                    (countOfOnestar / totalReviews) * 100;
                                final percentageOfTwostar =
                                    (countOfTwostar / totalReviews) * 100;
                                final percentageOfThreestar =
                                    (countOfThreestar / totalReviews) * 100;
                                final percentageOfFourstar =
                                    (countOfFourstar / totalReviews) * 100;
                                final percentageOfFivestar =
                                    (countOfFiveStar / totalReviews) * 100;
                                // Rounded percentages in string
                                String roundedPercentageOfOneStar =
                                    "${percentageOfOnestar.round().toString()}%";
                                String roundedPercentageOfTwoStar =
                                    "${percentageOfTwostar.round().toString()}%";
                                String roundedPercentageOfThreeStar =
                                    "${percentageOfThreestar.round().toString()}%";
                                String roundedPercentageOfFourStar =
                                    "${percentageOfFourstar.round().toString()}%";
                                String roundedPercentageOfFiveStar =
                                    "${percentageOfFivestar.round().toString()}%";

                                return Column(
                                  children: [
                                    //! REVIEW METRICS
                                    ViewProductDetailsWidgets
                                        .buildReviewMetrics(
                                            context,
                                            roundedRating,
                                            enhancedReviews,
                                            roundedPercentageOfFiveStar,
                                            roundedPercentageOfFourStar,
                                            roundedPercentageOfThreeStar,
                                            roundedPercentageOfTwoStar,
                                            roundedPercentageOfOneStar),
                                    //! ALL CUSTOMER REVIEWS
                                    ViewProductDetailsWidgets
                                        .buildCustomerReviews(
                                            context, enhancedReviews)
                                  ],
                                );
                              } else {
                                //! EMPTY REVIEWS DISPLAY
                                return ViewProductDetailsWidgets
                                    .buildEmptyReviewsDisplay(context);
                              }
                            }
                            return const Center(
                                child: Text("Something went wrong"));
                          }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
