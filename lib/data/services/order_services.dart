import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';

class OrderServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //! CREATE MULTIPLE ORDERS (ONE PER PRODUCT)
  Future<List<OrderModel>> createMultipleOrders({
    required List<ProductModel> products,
    required AddressModel address,
    required String paymentMode,
  }) async {
    final userId = _auth.currentUser!.uid;
    List<OrderModel> createdOrders = [];

    // Create a separate order for each product
    for (var product in products) {
      // Create order document in firestore
      final orderRef = _firestore.collection('orders').doc();

      final orderData = {
        'id': orderRef.id,
        'userId': userId,
        'products': [product.toMap()], // Only one product per order
        'address': address.toMap(),
        'totalAmount': product.offerPrice, // Individual product price
        'paymentMode': paymentMode,
        'orderDate': DateTime.now(),
        'status': OrderStatus.pending.toString()
      };

      await orderRef.set(orderData);

      log('SERVICES: CREATED USER ORDER: DOC ID IS ${orderRef.id} FOR PRODUCT ${product.name}');

      final newOrder = OrderModel(
        id: orderRef.id,
        products: [product],
        address: address,
        orderDate: DateTime.now(),
        totalAmount: product.offerPrice,
        paymentMode: paymentMode,
        status: OrderStatus.pending,
      );

      createdOrders.add(newOrder);
    }

    return createdOrders;
  }

  //! FETCH USER ORDERS
  Future<List<OrderModel>> fetchUserOrders() async {
    final userId = _auth.currentUser!.uid;
    final orderSnapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .get();

    final userOrders = orderSnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList();

    log('SERVICES: FETCH USER ORDERS: $userOrders');

    return userOrders;
  }

  //! UPDATE ORDER STATUS
  Future<void> updateOrderStatus(
      {required String orderId, required OrderStatus newStatus}) async {
    try {
      await _firestore.collection('orders').doc(orderId).update(
          {'status': newStatus.toString(), 'updatedAt': DateTime.now()});

      log('ADMIN SERVICES: Updated order $orderId status to $newStatus');
    } catch (error) {
      log('ADMIN SERVICES: Error updating order status - $error');
      rethrow;
    }
  }
}
