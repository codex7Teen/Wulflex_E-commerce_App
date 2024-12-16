import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  //! GET A PRODUCT REVIEW
  Stream<List<ReviewModel>> getProductReviews(String productId) {
    return _firestore
        .collection('reviews')
        .where('productId', isEqualTo: productId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ReviewModel.fromMap(doc.data(), documentId: doc.id))
            .toList());
  }
}
