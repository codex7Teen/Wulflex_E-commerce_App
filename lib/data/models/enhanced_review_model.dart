// Enhanced Review Model to include user details
import 'package:wulflex/data/models/review_model.dart';

class EnhancedReviewModel {
  final ReviewModel review;
  final String userName;
  final String? userImageUrl;

  EnhancedReviewModel({
    required this.review,
    required this.userName,
    this.userImageUrl,
  });
}
