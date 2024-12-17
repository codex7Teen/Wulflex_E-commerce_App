import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? id;
  final String? userId;
  final String productId;
  final double rating;
  final List<String> tags;
  final String selectedSizeOrWeight;
  final String reviewText;
  final DateTime createdAt;

  ReviewModel({
    this.id,
    this.userId,
    required this.productId,
    required this.rating,
    required this.tags,
    required this.selectedSizeOrWeight,
    required this.reviewText,
    required this.createdAt,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return ReviewModel(
      id: documentId ?? map['id'],
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      tags: List<String>.from(map['tags'] ?? []),
      selectedSizeOrWeight: map['selectedSizeOrWeight'] ?? '',
      reviewText: map['reviewText'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'rating': rating,
      'tags': tags,
      'selectedSizeOrWeight': selectedSizeOrWeight,
      'reviewText': reviewText,
      'createdAt': createdAt,
    };
  }
}
