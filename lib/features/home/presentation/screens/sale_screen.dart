import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/home/bloc/product_bloc/product_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_itemCard_widget.dart';

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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
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
                    'Something went wrong. Please retry...',
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
