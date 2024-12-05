import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/cart_bloc/cart_bloc.dart';
import 'package:wulflex/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/widgets/view_product_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';

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
                context, 'Item added to cart... 🎉🎉🎉');
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
                          buildSizeAndSizeChartText(widget.productModel),
                          Visibility(
                              visible: widget.productModel.sizes.isNotEmpty,
                              child: SizedBox(height: 8)),
                          buildSizeSelectors(selectedSize, widget.productModel,
                              (size) => updateSelectedSize(size)),
                          buildiWeightText(widget.productModel),
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
                          buildDescriptionTitle(),
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
                          SizedBox(height: 20)
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
