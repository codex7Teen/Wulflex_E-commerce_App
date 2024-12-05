import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/product_bloc/product_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_itemCard_widget.dart';

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
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor:
          isLightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: isLightTheme
              ? AppColors.whiteThemeColor
              : AppColors.blackThemeColor,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 47),
            child: Row(
              children: [
                // Back Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: isLightTheme
                        ? AppColors.blackThemeColor
                        : AppColors.whiteThemeColor,
                  ),
                ),
                const SizedBox(width: 15),
                // Search Bar
                Expanded(
                  child: Container(
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
                        Image.asset('assets/Search.png',
                            scale: 28, color: AppColors.darkishGrey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            onChanged: (value) {
                              // Handle search logic here
                              setState(() {
                                _searchQuery = value;
                              });
                              // Get current products from bloc state and filter
                              if (context.read<ProductBloc>().state
                                  is ProductLoaded) {
                                final products = (context
                                        .read<ProductBloc>()
                                        .state as ProductLoaded)
                                    .products;
                                _filterAndSortProducts(products);
                              }
                            },
                            style: AppTextStyles.searchBarTextStyle,
                            decoration: InputDecoration(
                              hintText: 'Search by product or category',
                              hintStyle: AppTextStyles.searchBarHintText,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            const SizedBox(height: 9),
            // Filter Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters:',
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
                      child:
                          Text(value, style: AppTextStyles.searchFilterHeading),
                    );
                  }).toList(),
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
                    _filteredProducts = state.products;
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 7.5,
                              childAspectRatio: 0.63),
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
