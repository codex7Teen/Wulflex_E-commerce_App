import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/data/models/product_model.dart';

class CartServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Get current user id
  String get _userId => _auth.currentUser!.uid;

  //! ADD TO CART SERVICE
  Future<void> addToCart(ProductModel product) async {
    try {
      // Create a unique cart item identifier that includes both product ID and selected size or selected weight
      final cartItemId =
          '${product.id}_${product.selectedSize ?? product.selectedWeight ?? 'default'}';

      // Create a cart-specific version of the product that includes the cart item ID
      final cartProduct = product.copyWithCartDetails(
        cartItemId: cartItemId,
      );

      // Reference to the specified cart item
      final cartRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .doc(cartItemId);

      final docSnapshot = await cartRef.get();

      if (docSnapshot.exists) {
        // Product with this specific size or weight exists, so increment the quantity
        await cartRef.update({'quantity': FieldValue.increment(1)});
      } else {
        // Create a new cart item with the unique identifier
        // Modify the toMap method to include the custom cart item ID if needed
        await cartRef.set(cartProduct.toMap());
      }
    } catch (error) {
      log('Error adding cart items: $error');
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
        return ProductModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      log('Error fetching cart items: $e');
      return [];
    }
  }

  //! REMOVE FROM CART
  Future<void> removeFromCart(String cartItemId) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(cartItemId)
        .delete();
  }

  //! CLEAR ENTIRE CART
  Future<void> clearCart() async {
    try {
      final cartCollection =
          _firestore.collection('users').doc(_userId).collection('cart');

      // get all documents in the cart
      final snapShot = await cartCollection.get();

      // Delete each document
      for (DocumentSnapshot doc in snapShot.docs) {
        await doc.reference.delete();
      }
      log('SERVICES: CART FULLY CLEARED');
    } catch (error) {
      log('Error clearing cart: $error');
    }
  }

  //! UPDATE CART ITEM QUANTITY
  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('cart')
          .doc(cartItemId)
          .update({'quantity': quantity});
    } catch (error) {
      log('SERVICES: ERROR UPDATING CART ITEM QUANTITY: $error');
    }
  }
}
