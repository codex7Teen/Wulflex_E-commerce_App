import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wulflex/data/models/enhanced_review_model.dart';
import 'package:wulflex/data/models/review_model.dart';

class ReviewServices {
  final _firestore = FirebaseFirestore.instance;

  //! ADD A NEW REVIEW
  Future<void> addReview(ReviewModel review) async {
    try {
      await _firestore.collection('reviews').add(review.toMap());
    } catch (error) {
      log('SERVICES: Failed to add review: $error');
      throw Exception('SERVICES: Failed to add review: $error');
    }
  }

  // //! GET A PRODUCT REVIEW
  // Stream<List<ReviewModel>> getProductReviews(String productId) {
  //   return _firestore
  //       .collection('reviews')
  //       .where('productId', isEqualTo: productId)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => ReviewModel.fromMap(doc.data(), documentId: doc.id))
  //           .toList());
  // }

    //! GET A PRODUCT REVIEW WITH USER DETAILS
  Stream<List<EnhancedReviewModel>> getProductReviewsWithUserDetails(String productId) {
    return _firestore
        .collection('reviews')
        .where('productId', isEqualTo: productId)
        .snapshots()
        .asyncMap((snapshot) async {
          // Create a list to store enhanced reviews
          List<EnhancedReviewModel> enhancedReviews = [];

          // Process each review document
          for (var doc in snapshot.docs) {
            // Create review model
            final reviewModel = ReviewModel.fromMap(doc.data(), documentId: doc.id);
            
            // Fetch user details
            final userDoc = await _firestore
                .collection('users')
                .doc(reviewModel.userId)
                .get();

            // Create enhanced review
            if (userDoc.exists) {
              final userData = userDoc.data()!;
              enhancedReviews.add(EnhancedReviewModel(
                review: reviewModel,
                userName: userData['name'] ?? 'Anonymous',
                userImageUrl: userData['userImage']
              ));
            } else {
              // Fallback if user document not found
              enhancedReviews.add(EnhancedReviewModel(
                review: reviewModel,
                userName: 'Anonymous',
                userImageUrl: null
              ));
            }
          }

          return enhancedReviews;
        });
  }
}
