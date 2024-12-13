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
        products: map['products'] ?? '',
        address: map['address'] ?? '',
        orderDate: map['orderDate'] ?? '',
        totalAmount: map['totalAmount'] ?? '',
        paymentMode: map['paymentMode'] ?? '',
        status: map['status'] ?? '');
  }
}

// Enum for Order Status
enum OrderStatus { pending, processing, shipped, delivered, cancelled }
