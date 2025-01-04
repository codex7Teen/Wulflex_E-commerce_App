import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/data/models/review_model.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/shared/widgets/custom_green_button_widget.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class RateProductScreenWidgets {
  static Widget buildRatetheproductheading(BuildContext context) {
    return Text(
      'RATE THE PRODUCT',
      style: AppTextStyles.screenSubHeadings(context),
    );
  }

  static Widget buildSecondaryRateHeading(BuildContext context) {
    return Text(
      'How much would you rate the product?',
      style: AppTextStyles.rateScreenMiniText(context),
    );
  }

  static Widget buildRatingBar(
      BuildContext context, double rating, ValueChanged onRatingUpdate) {
    return Center(
      child: RatingBar.builder(
        initialRating: rating,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColors.greenThemeColor, // Set the color for the stars
        ),
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }

  static Widget buildRatingIndicator(BuildContext context, double rating) {
    return Center(
      child: Text(
        '$rating Rating',
        style: AppTextStyles.rateScreenMiniText(context),
      ),
    );
  }

  static Widget buildDivider(BuildContext context) {
    return Divider(
      color: isLightTheme(context)
          ? AppColors.lightGreyThemeColor
          : AppColors.greyThemeColor,
    );
  }

  static Widget buildWriteareviewText(BuildContext context) {
    return Text(
      'Write a review on the product. 💖',
      style: AppTextStyles.rateScreenSubheadingText(context),
    );
  }

  static Widget buildReviewTags(BuildContext context, List<String> tags,
      Set<String> selectedTags, Function toggleTag) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        bool isSelected = selectedTags.contains(tag);
        return GestureDetector(
          onTap: () => toggleTag(tag),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.greenThemeColor
                  : AppColors.lightGreyThemeColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              tag,
              style: AppTextStyles.rateScreenSupermini(context).copyWith(
                  color: isSelected ? Colors.white : AppColors.greyThemeColor),
            ),
          ),
        );
      }).toList(),
    );
  }

  static Widget buildReviewInputField(
      BuildContext context, TextEditingController ratingTextController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isLightTheme(context)
                  ? AppColors.appBarLightGreyThemeColor
                  : AppColors.greyThemeColor)),
      child: TextFormField(
        controller: ratingTextController,
        style: AppTextStyles.ratingScreenTextFieldStyle(context),
        maxLines: 8,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Tell us what you think of the product...',
            hintStyle: AppTextStyles.ratingScreenTextFieldhintStyle(context)),
      ),
    );
  }

  static Widget buildSaveReviewButton(
      BuildContext context,
      ProductModel productModel,
      double rating,
      Set<String> selectedTags,
      TextEditingController ratingTextController) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        return GreenButtonWidget(
          isLoading: state is ReviewLoading,
          buttonText: 'Add review',
          borderRadius: 25,
          width: 1,
          addIcon: true,
          icon: Icons.check_sharp,
          onTap: () {
            log(productModel.id!);
            if (rating < 1) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Please rate the product before submitting.',
                  icon: Icons.error);
            } else {
              // create a review model
              final review = ReviewModel(
                  productId: productModel.id!,
                  rating: rating,
                  tags: selectedTags.toList(),
                  reviewText: ratingTextController.text.trim(),
                  selectedSizeOrWeight: productModel.selectedSize ??
                      productModel.selectedWeight ??
                      '',
                  createdAt: DateTime.now());

              // Dispatch add event event
              context.read<ReviewBloc>().add(AddReviewEvent(review: review));
            }
          },
        );
      },
    );
  }
}
