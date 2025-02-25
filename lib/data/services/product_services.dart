// product_services.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wulflex/data/models/product_model.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;

//! GET ALL PRODUCTS IN DESCENDING ORDER
  Stream<List<ProductModel>> getProducts() {
    return _firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data(), documentId: doc.id))
            .toList());
  }
}