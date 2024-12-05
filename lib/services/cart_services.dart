import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/models/product_model.dart';

class CartServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Get current user id
  String get _userId => _auth.currentUser!.uid;

  //! ADD TO CART SERVICE
  Future<void> addToCart(ProductModel product) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .doc(product.id)
          .set(product.toMap());
    } catch (error) {
      log('Error fetching cart items: $error');
    }
  }

  //! FETCH CART ITEMS
  Future<List<ProductModel>> fetchCartItems() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .get();

      return querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data(), documentId: doc.id);
      }).toList();
    } catch (e) {
      log('Error fetching cart items: $e');
      return [];
    }
  }

  //! REMOVE FROM CART
  Future<void> removeFromCart(String productId) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productId)
        .delete();
  }
}
