import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/home/bloc/category_bloc/category_bloc.dart';
import 'package:wulflex/features/home/presentation/screens/categorized_product_screen.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenAllCategories extends StatefulWidget {
  final String screenTitle;
  const ScreenAllCategories({super.key, required this.screenTitle});

  @override
  State<ScreenAllCategories> createState() => _ScreenAllCategoriesState();
}

class _ScreenAllCategoriesState extends State<ScreenAllCategories> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(LoadAllCategoryDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Default images for default categories
    final Map<String, String> defaultCategoryImages = {
      'Equipments': 'assets/equipments.jpg',
      'Supplements': 'assets/suppliments.jpg',
      'Accessories': 'assets/accessories.jpeg',
      'Apparels': 'assets/apparels.jpeg'
    };

    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, widget.screenTitle, 0.080),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: isLightTheme(context)
                    ? AppColors.blackThemeColor
                    : AppColors.whiteThemeColor,
              ),
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text(
                'Categories fetch error!',
                style: TextStyle(
                  color: isLightTheme(context)
                      ? AppColors.blackThemeColor
                      : AppColors.whiteThemeColor,
                ),
              ),
            );
          } else if (state is CategoryDetailsLoaded) {
            final categories = state.categoryDetails;

            log('Total Categories: ${categories.length}');
            for (var category in categories) {
              log('Category Name: ${category['name']}');
              log('Image URL: ${category['image_url']}');
            }

            return Padding(
              padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.88),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryName = category['name'];
                  final imageUrl = category['image_url'] ?? '';

                  // Use default image for default categories, network image for custom
                  Widget imageWidget = imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            log('Network Image Error: $error');
                            return Icon(Icons.error);
                          },
                        )
                      : Image.asset(
                          defaultCategoryImages[categoryName]!,
                          fit: BoxFit.cover,
                        );

                  return GestureDetector(
                    onTap: () {
                      NavigationHelper.navigateToWithoutReplacement(
                        context,
                        ScreenCategorizedProduct(
                          categoryName: categoryName,
                        ),
                      );
                    },
                    child: GridTile(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 100,
                              child: imageWidget,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categoryName,
                            style: AppTextStyles.allCategoriesPageCategoryText(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: Text(
              'Categories fetch error!',
              style: TextStyle(
                color: isLightTheme(context)
                    ? AppColors.blackThemeColor
                    : AppColors.whiteThemeColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
