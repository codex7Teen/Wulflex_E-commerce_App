import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/features/account/bloc/review_bloc/review_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/rate_product_screen_widgets.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';

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
              Future.delayed(const Duration(milliseconds: 500),
                  () => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RateProductScreenWidgets.buildRatetheproductheading(context),
                  const SizedBox(height: 2),
                  RateProductScreenWidgets.buildSecondaryRateHeading(context),
                  const SizedBox(height: 18),
                  // Rating Bar
                  RateProductScreenWidgets.buildRatingBar(
                    context,
                    _rating,
                    (rating) {
                      setState(() {
                        _rating = rating; // Updates the rating state
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  RateProductScreenWidgets.buildRatingIndicator(
                      context, _rating),
                  const SizedBox(height: 8),
                  RateProductScreenWidgets.buildDivider(context),
                  const SizedBox(height: 10),
                  RateProductScreenWidgets.buildWriteareviewText(context),
                  const SizedBox(height: 12),
                  RateProductScreenWidgets.buildReviewTags(
                      context, _tags, _selectedTags, _toggleTag),
                  const SizedBox(height: 18),
                  RateProductScreenWidgets.buildReviewInputField(
                      context, _ratingTextController),
                  const SizedBox(height: 20),
                  RateProductScreenWidgets.buildSaveReviewButton(
                      context,
                      widget.productModel,
                      _rating,
                      _selectedTags,
                      _ratingTextController),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }
}
