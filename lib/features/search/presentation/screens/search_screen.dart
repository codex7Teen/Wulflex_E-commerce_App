import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/search/presentation/widgets/search_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_itemCard_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenSearchScreen extends StatefulWidget {
  const ScreenSearchScreen({super.key});

  @override
  State<ScreenSearchScreen> createState() => _ScreenSearchScreenState();
}

class _ScreenSearchScreenState extends State<ScreenSearchScreen> {
  final _focusNode = FocusNode();
  List<ProductModel> _filteredProducts = [];
  String _searchQuery = '';
  String _selectedFilter = 'Featured';

  @override
  void initState() {
    super.initState();
    // Load all products initially
    context.read<ProductBloc>().add(LoadProducts());
    // Automatically focus the TextField when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Filter and sort products
  void _filterAndSortProducts(List<ProductModel> products) {
    if (_searchQuery.isEmpty) {
      _filteredProducts = products;
    } else {
      _filteredProducts = products.where((product) {
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

    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: isLightTheme(context)
              ? AppColors.whiteThemeColor
              : AppColors.blackThemeColor,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 47),
            child: SearchScreenWidgets.buildSearchbarWithBackbutton(
                context, screenWidth, _focusNode, onChanged: (value) {
              // Handle search logic here
              setState(() {
                _searchQuery = value;
              });
              // Get current products from bloc state and filter
              if (context.read<ProductBloc>().state is ProductLoaded) {
                final products =
                    (context.read<ProductBloc>().state as ProductLoaded)
                        .products;
                _filterAndSortProducts(products);
              }
            }),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            const SizedBox(height: 9),
            // Filter Dropdown
            SearchScreenWidgets.buildFilterDropdown(context, _selectedFilter,
                onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedFilter = value;
                });
                if (context.read<ProductBloc>().state is ProductLoaded) {
                  final products =
                      (context.read<ProductBloc>().state as ProductLoaded)
                          .products;
                  _filterAndSortProducts(products);
                }
              }
            }),
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
                    _filteredProducts = state.products;
                  }

                  if (_filteredProducts.isEmpty) {
                    return SearchScreenWidgets
                        .buildSearchedProductNotFoundDisplay(context);
                  }
                  // Show product card
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 7.5,
                              childAspectRatio: 0.604),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        return buildItemCard(context, _filteredProducts[index]);
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
    );
  }
}
