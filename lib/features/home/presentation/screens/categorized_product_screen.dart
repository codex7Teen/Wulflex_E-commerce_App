import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_itemCard_widget.dart';

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
  String _selectedFilter = 'Featured';

  @override
  void initState() {
    super.initState();
    // Load all products initially
    context.read<ProductBloc>().add(LoadProducts());
  }

  // Filter and sort products
  void _filterAndSortProducts(List<ProductModel> products) {
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

    // Apply sorting based on the selected filter
    if (_selectedFilter == 'Price: Low to High') {
      _filteredProducts.sort((a, b) => a.offerPrice.compareTo(b.offerPrice));
    } else if (_selectedFilter == 'Price: High to Low') {
      _filteredProducts.sort((a, b) => b.offerPrice.compareTo(a.offerPrice));
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
                  color: isLightTheme
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
                          setState(() {
                            _searchQuery = value;
                          });
                          if (context.read<ProductBloc>().state
                              is ProductLoaded) {
                            final products = (context.read<ProductBloc>().state
                                    as ProductLoaded)
                                .products;
                            _filterAndSortProducts(products);
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
              const SizedBox(height: 9),
              // Filter Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort by:',
                    style: AppTextStyles.searchFilterHeading,
                  ),
                  DropdownButton<String>(
                    value: _selectedFilter,
                    borderRadius: BorderRadius.circular(18),
                    items: [
                      'Featured',
                      'Price: Low to High',
                      'Price: High to Low',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: AppTextStyles.searchFilterHeading),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedFilter = value;
                        });
                        if (context.read<ProductBloc>().state
                            is ProductLoaded) {
                          final products = (context.read<ProductBloc>().state
                                  as ProductLoaded)
                              .products;
                          _filterAndSortProducts(products);
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Build products
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ProductLoaded) {
                    if (_searchQuery.isEmpty && _selectedFilter == 'Featured') {
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
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 7.5,
                                childAspectRatio: 0.604),
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
