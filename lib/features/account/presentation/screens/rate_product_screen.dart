import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/data/models/review_model.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenRateProduct extends StatefulWidget {
  final ProductModel productModel;
  const ScreenRateProduct({super.key, required this.productModel});

  @override
  State<ScreenRateProduct> createState() => _ScreenRateProductState();
}

class _ScreenRateProductState extends State<ScreenRateProduct> {
  final TextEditingController _ratingTextController = TextEditingController();
  double _rating = 0.0; // Holds the selected rating
  final Set<String> _selectedTags = {}; // Tracks selected tags

  final List<String> _tags = [
    'Amazing',
    'Really good service',
    'Really loved it',
    'Awesome product'
  ];

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor(context),
      appBar: customAppbarWithBackbutton(context, "FEEDBACK", 0.16),
      body: SingleChildScrollView(
        child: BlocConsumer<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state is ReviewAddedSuccess) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Review added success... 🎉🎉🎉');
              Future.delayed(
                  Duration(milliseconds: 500), () => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RATE THE PRODUCT',
                    style: AppTextStyles.screenSubHeadings(context),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'How much would you rate the product?',
                    style: AppTextStyles.rateScreenMiniText(context),
                  ),
                  const SizedBox(height: 18),
                  // Rating Bar
                  Center(
                    child: RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: AppColors
                            .greenThemeColor, // Set the color for the stars
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating; // Updates the rating state
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      '$_rating Rating',
                      style: AppTextStyles.rateScreenMiniText(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: isLightTheme(context)
                        ? AppColors.lightGreyThemeColor
                        : AppColors.greyThemeColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Write a review on the product. 💖',
                    style: AppTextStyles.rateScreenSubheadingText(context),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      bool isSelected = _selectedTags.contains(tag);
                      return GestureDetector(
                        onTap: () => _toggleTag(tag),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.greenThemeColor
                                : AppColors.lightGreyThemeColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            tag,
                            style: AppTextStyles.rateScreenSupermini(context)
                                .copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.greyThemeColor),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: isLightTheme(context)
                                ? AppColors.appBarLightGreyThemeColor
                                : AppColors.greyThemeColor)),
                    child: TextFormField(
                      controller: _ratingTextController,
                      style: AppTextStyles.ratingScreenTextFieldStyle(context),
                      maxLines: 8,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tell us what you think of the product...',
                          hintStyle:
                              AppTextStyles.ratingScreenTextFieldhintStyle(
                                  context)),
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<ReviewBloc, ReviewState>(
                    builder: (context, state) {
                      return GreenButtonWidget(
                        isLoading: state is ReviewLoading,
                        buttonText: 'Add review',
                        borderRadius: 25,
                        width: 1,
                        addIcon: true,
                        icon: Icons.check_sharp,
                        onTap: () {
                          log(widget.productModel.id!);
                          if (_rating < 1) {
                            CustomSnackbar.showCustomSnackBar(context,
                                'Please rate the product before submitting.',
                                icon: Icons.error);
                          } else {
                            // create a review model
                            final review = ReviewModel(
                                productId: widget.productModel.id!,
                                rating: _rating,
                                tags: _selectedTags.toList(),
                                reviewText: _ratingTextController.text.trim(),
                                selectedSizeOrWeight:
                                    widget.productModel.selectedSize ??
                                        widget.productModel.selectedWeight ??
                                        '',
                                createdAt: DateTime.now());

                            // Dispatch add event event
                            context
                                .read<ReviewBloc>()
                                .add(AddReviewEvent(review: review));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
