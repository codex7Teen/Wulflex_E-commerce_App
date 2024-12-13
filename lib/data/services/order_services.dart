import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';

class OrderServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //! CREATE ORDER
  Future<OrderModel> createOrder(
      {required List<ProductModel> products,
      required AddressModel address,
      required double totalAmount, required String paymentMode}) async {
    final userId = _auth.currentUser!.uid;

    // Create order document in firestore
    final orderRef = _firestore.collection('orders').doc();

    final orderData = {
      'id': orderRef.id,
      'userId': userId,
      'products': products.map((p) => p.toMap()).toList(),
      'address': address.toMap(),
      'totalAmount': totalAmount,
      'paymentMode': paymentMode,
      'orderDate': DateTime.now(),
      'status': OrderStatus.pending.toString()
    };

    await orderRef.set(orderData);

    log('SERVICES: CREATED USER ORDER: DOC ID IS ${orderRef.id}');

    return OrderModel(
        id: orderRef.id,
        products: products,
        address: address,
        orderDate: DateTime.now(),
        totalAmount: totalAmount,
        paymentMode: paymentMode,
        status: OrderStatus.pending);
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
}
