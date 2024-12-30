import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
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

            return Padding(
              padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  // Increased aspect ratio to give more vertical space
                  childAspectRatio: 0.75,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryName = category['name'];
                  final imageUrl = category['image_url'] ?? '';

                  Widget imageWidget = imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          width: double.infinity,
                          height: 100,
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return SizedBox(
                              width: 22,
                              height: 22,
                              child:
                                  Image.asset('assets/wulflex_logo_nobg.png'),
                            );
                          },
                        )
                      : Image.asset(
                          defaultCategoryImages[categoryName]!,
                          fit: BoxFit.cover,
                          height: 100,
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
                    child: Container(
                      // Added container with fixed height
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Add this
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: imageWidget,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              categoryName,
                              style:
                                  AppTextStyles.allCategoriesPageCategoryText(
                                      context),
                              textAlign: TextAlign.center,
                              maxLines: 2, // Limit text to 2 lines
                              overflow:
                                  TextOverflow.ellipsis, // Handle text overflow
                            ),
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
