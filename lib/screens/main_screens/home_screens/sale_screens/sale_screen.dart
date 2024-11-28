import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/product_bloc/product_bloc.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/utils/consts/app_colors.dart';
import 'package:wulflex/utils/consts/text_styles.dart';
import 'package:wulflex/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/widgets/custom_itemCard_widget.dart';

class ScreenSaleScreen extends StatefulWidget {
  final String screenName;
  const ScreenSaleScreen({super.key, required this.screenName});

  @override
  State<ScreenSaleScreen> createState() => _ScreenSaleScreenState();
}

class _ScreenSaleScreenState extends State<ScreenSaleScreen> {
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // Load all products initially
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor:
          isLightTheme ? AppColors.whiteThemeColor : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, widget.screenName),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 15),
          child: Column(
            children: [
              // Build products
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ProductLoaded) {
                    // Filter products by category first
                    _filteredProducts = state.products
                        .where((product) => product.isOnSale)
                        .toList();

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
