import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final AddressModel address;
  final DateTime orderDate;
  final double totalAmount;
  final String paymentMode;
  final OrderStatus status;

  OrderModel(
      {required this.id,
      required this.products,
      required this.address,
      required this.orderDate,
      required this.totalAmount,
      required this.paymentMode,
      required this.status});

  // From map
  factory OrderModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return OrderModel(
      id: documentId ?? map['id'] ?? '',
      products: (map['products'] as List)
          .map((productMap) => ProductModel.fromMap(productMap))
          .toList(),
      address: AddressModel.fromMap(map['address']),
      orderDate: (map['orderDate'] is Timestamp)
          ? (map['orderDate'] as Timestamp).toDate()
          : DateTime.parse(map['orderDate'] ?? DateTime.now().toString()),
      totalAmount: (map['totalAmount'] is int)
          ? (map['totalAmount'] as int).toDouble()
          : double.parse(map['totalAmount'].toString()),
      paymentMode: map['paymentMode'] ?? '',
      status: _parseOrderStatus(map['status']),
    );
  }

  // Helper method to parse OrderStatus
  static OrderStatus _parseOrderStatus(String? statusString) {
    if (statusString == null) return OrderStatus.pending;
    return OrderStatus.values.firstWhere(
      (status) => status.toString() == statusString,
      orElse: () => OrderStatus.pending,
    );
  }
}

// Enum for Order Status
enum OrderStatus { pending, processing, shipped, delivered, cancelled }
