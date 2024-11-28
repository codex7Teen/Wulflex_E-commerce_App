
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/product_bloc/product_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_itemCard_widget.dart';

class ScreenCategorizedProduct extends StatefulWidget {
  final String categoryName;
  const ScreenCategorizedProduct({super.key, required this.categoryName});

  @override
  State<ScreenCategorizedProduct> createState() =>
      _ScreenCategorizedProductState();
}

class _ScreenCategorizedProductState extends State<ScreenCategorizedProduct> {
  List<ProductModel> _filteredProducts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load all products initially
    context.read<ProductBloc>().add(LoadProducts());
  }

  // filter products
  void _filterProducts(List<ProductModel> products) {
    // First filter by category
    List<ProductModel> categoryProducts = products
        .where((product) =>
            product.category.toLowerCase() == widget.categoryName.toLowerCase())
        .toList();

    // Then apply search filter if search query exists
    if (_searchQuery.isEmpty) {
      _filteredProducts = categoryProducts;
    } else {
      _filteredProducts = categoryProducts.where((product) {
        return product.brandName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor:
          isLightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, widget.categoryName,
          widget.categoryName.length <= 9 ? 0.150 : 0.100),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 15),
          child: Column(
            children: [
              // Search Bar
              Container(
                height: 50,
                width: screenWidth * 0.92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.lightGreyThemeColor
                      : AppColors.whiteThemeColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Image.asset(
                      'assets/Search.png',
                      scale: 28,
                      color: AppColors.darkishGrey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          // Handle search logic here
                          setState(() {
                            _searchQuery = value;
                          });
                          // Get current products from bloc state and filter
                          if (context.read<ProductBloc>().state
                              is ProductLoaded) {
                            final products = (context.read<ProductBloc>().state
                                    as ProductLoaded)
                                .products;
                            _filterProducts(products);
                          }
                        },
                        style: AppTextStyles.searchBarTextStyle,
                        decoration: InputDecoration(
                          hintText:
                              'Search for any ${widget.categoryName.toLowerCase()}...',
                          hintStyle: AppTextStyles.searchBarHintText,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              // Build products
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ProductLoaded) {
                    // Filter products by category first
                    if (_searchQuery.isEmpty) {
                      _filteredProducts = state.products
                          .where((product) =>
                              product.category.toLowerCase() ==
                              widget.categoryName.toLowerCase())
                          .toList();
                    }

                    if (_filteredProducts.isEmpty) {
                      return Center(
                          child: Text('No products found! 😔',
                              style: AppTextStyles.emptyProductsMessageText(
                                  context)));
                    }
                    // Show product card
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 7.5,
                            childAspectRatio: 0.63),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          return buildItemCard(
                              context, _filteredProducts[index]);
                        },
                      ),
                    );
                  }
                  return Center(
                      child: Text(
                    'Start searching for products...',
                    style: AppTextStyles.emptyProductsMessageText(context),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}