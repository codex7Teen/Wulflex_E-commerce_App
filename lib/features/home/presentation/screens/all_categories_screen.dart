import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/home/bloc/category_bloc/category_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/home/presentation/widgets/all_category_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
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
            //! CATEGORIES GRID VIEW
            return AllCategoryScreenWidgets.buildCategoriesGridView(
                categories, defaultCategoryImages);
          }
          return Center(
            child: Text(
              'Categories fetch error!.. Please retry.',
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
