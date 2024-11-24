import 'package:flutter/material.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/screens/main_screens/view_product_screen/widgets/view_product_widgets.dart';
import 'package:wulflex/utils/consts/app_colors.dart';

class ScreenViewProducts extends StatefulWidget {
  final ProductModel productModel;
  const ScreenViewProducts({super.key, required this.productModel});

  @override
  State<ScreenViewProducts> createState() => _ScreenViewProductsState();
}

class _ScreenViewProductsState extends State<ScreenViewProducts> {
  // Track selected size (only one can be selected)
  String? selectedSize;

  void updateSelectedSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  // Track expand or collapse of the description
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: AppColors.lightGreyThemeColor,
      body: CustomScrollView(
        slivers: [
          //! A P P - B A R
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            pinned: false,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              background: buildAppBarWithIcons(context),
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
                        buildSizeAndSizeChartText(),
                        SizedBox(height: 8),
                        buildWeightAndSizeSelectors(
                            selectedSize,
                            widget.productModel,
                            (size) => updateSelectedSize(size)),
                        SizedBox(height: 24),
                        buildPriceDetailsContainer(context, widget.productModel),
                        SizedBox(height: 24),
                        buildDescriptionTitle(),
                        SizedBox(height: 6),
                        buildDescription(context, isExpanded, widget.productModel),
                        buildReammoreAndReadlessButton(
                            isExpanded,
                            () => setState(() {
                                  isExpanded = !isExpanded;
                                }),
                            context),
                        SizedBox(height: 24),
                        buildAddToCartButton(),
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
    );
  }
}
