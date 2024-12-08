import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryServices {
  final _firestore = FirebaseFirestore.instance;

  // Default categories that should always appear
  static const List<String> defaultCategories = [
    'Equipments',
    'Supplements',
    'Accessories',
    'Apparels',
  ];

  //! GET ALL CATEGORY DETAILS
  Future<List<Map<String, dynamic>>> getAllCategoryDetails() async {
    // Fetch custom categories from firestore
    QuerySnapshot snapshot = await _firestore
        .collection('custom_categories')
        .orderBy('timestamp', descending: true)
        .get();

    List<Map<String, dynamic>> customCategoriesData = snapshot.docs
        .map((doc) => {
              'id': doc.id,
              'name': doc['name'] as String,
              'image_url': doc['image_url'] as String,
              'timestamp': doc['timestamp']
            })
        .toList();

    // Combine with default categories
    List<Map<String, dynamic>> allCategories = [
      ...defaultCategories.map((name) => {
            'id': name.toLowerCase(),
            'name': name,
            'image_url': '', // Default categories might not have images
            'timestamp': null
          }),
      ...customCategoriesData
    ];
    log('Services- Got all categories');
    return allCategories;
  }
}
