import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/data/models/product_model.dart';

class FavoriteServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Get current user Id
  String get _userId => _auth.currentUser!.uid;

//! GET ALL FAVORITES SERVICE
  Future<List<ProductModel>> getUserFavorites() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), documentId: doc.id))
        .toList();
  }

//! ADD TO FAVORITE SERVICE
  Future<void> addFavorite(ProductModel product) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .doc(product.id)
        .set(product.toMap());
    log('SERVICES: FAVORITED');
  }

//! REMOVE FROM FAVORITE SERVICE
  Future<void> removeFavorite(String productId) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .doc(productId)
        .delete();
    log('SERVICES: UN-FAVORITED');
  }
}
