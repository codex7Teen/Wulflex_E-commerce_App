import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/features/cart/bloc/cart_bloc/cart_bloc.dart';
import 'package:wulflex/features/favorite/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/home/presentation/widgets/view_product_details_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
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
                background: buildAppBarWithIcons(context, widget.productModel),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  //! ITEM IMAGE WITH SLIDER (PAGEVIEW)
                  buildItemImageSlider(
                      context, pageController, widget.productModel),
                  SizedBox(height: 4),
                  buildPageIndicator(
                      pageController, context, widget.productModel),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
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
                          SizedBox(height: 10),
                          buildProductHeadingText(context, widget.productModel),
                          SizedBox(height: 14),
                          buildRatingsContainer(),
                          SizedBox(height: 20),
                          buildSizeAndSizeChartText(
                              widget.productModel, context),
                          Visibility(
                              visible: widget.productModel.sizes.isNotEmpty,
                              child: SizedBox(height: 8)),
                          buildSizeSelectors(selectedSize, widget.productModel,
                              (size) => updateSelectedSize(size)),
                          buildiWeightText(widget.productModel, context),
                          Visibility(
                              visible: widget.productModel.weights.isNotEmpty,
                              child: SizedBox(height: 8)),
                          buildWeightSelectors(
                              selectedWeight,
                              widget.productModel,
                              (weight) => updateSelectedWeight(weight)),
                          SizedBox(height: 24),
                          buildPriceDetailsContainer(
                              context, widget.productModel),
                          SizedBox(height: 24),
                          buildDescriptionTitle(context),
                          SizedBox(height: 6),
                          buildDescription(
                              context, isExpanded, widget.productModel),
                          buildReammoreAndReadlessButton(
                              isExpanded,
                              () => setState(() {
                                    isExpanded = !isExpanded;
                                  }),
                              context),
                          SizedBox(height: 24),
                          buildAddToCartButton(context, widget.productModel,
                              selectedWeight, selectedSize),
                          SizedBox(height: 24),
                          Text("RATINGS & REVIEWS",
                              style:
                                  AppTextStyles.viewProductTitleText(context)),
                          SizedBox(height: 6),
                          BlocBuilder<ReviewBloc, ReviewState>(
                              builder: (context, state) {
                            if (state is ReviewLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is ReviewError) {
                              return Center(
                                  child: Text('Failed to load reviews.'));
                            } else if (state is ReviewsLoaded) {
                              final reviews = state.reviews;
                              if (reviews.isNotEmpty) {
                                return Text(
                                  "'review'",
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                          'assets/lottie/no_reviews_lottie.json',
                                          width: 200),
                                      Text(
                                        'No reviews yet. Check back later\nfor customer insights.',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.emptySectionText(
                                            context),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }
                            return Center(child: Text("Something went wrong"));
                          }),
                          SizedBox(height: 20),
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
