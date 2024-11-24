// product_services.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wulflex/models/product_model.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList());
  }

  Future<List<ProductModel>> getLatestProducts() {
    return _firestore
        .collection('products')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList());
  }
}
