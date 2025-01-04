import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/home/presentation/screens/categorized_product_screen.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class AllCategoryScreenWidgets {
  static Widget buildCategoriesGridView(List<Map<String, dynamic>> categories,
      Map<String, String> defaultCategoryImages) {
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
                      child: Image.asset('assets/wulflex_logo_nobg.png'),
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
                          AppTextStyles.allCategoriesPageCategoryText(context),
                      textAlign: TextAlign.center,
                      maxLines: 2, // Limit text to 2 lines
                      overflow: TextOverflow.ellipsis, // Handle text overflow
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

  // static Widget buildCategoriesCard(
  //     BuildContext context,
  //     List<String> defaultCategoryImages,
  //     List<String> defaultCategoryNames,
  //     int index) {
  //   return GestureDetector(
  //     onTap: () => NavigationHelper.navigateToWithoutReplacement(context,
  //         ScreenCategorizedProduct(categoryName: defaultCategoryNames[index])),
  //     child: GridTile(
  //         child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: SizedBox(
  //               height: 100,
  //               child: Image.asset(
  //                 defaultCategoryImages[index],
  //                 fit: BoxFit.cover,
  //                 width: double.infinity,
  //               ),
  //             )),
  //         const SizedBox(height: 8),
  //         Text(
  //           defaultCategoryNames[index],
  //           style: TextStyle(
  //             color: isLightTheme(context)
  //                 ? AppColors.blackThemeColor
  //                 : AppColors.whiteThemeColor,
  //             fontWeight: FontWeight.bold,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     )),
  //   );
  // }
}
