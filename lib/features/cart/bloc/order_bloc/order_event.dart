part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

//! CREATE ORDER EVENT
class CreateOrderEvent extends OrderEvent {
  final List<ProductModel> products;
  final String paymentMode;
  final AddressModel address;

  CreateOrderEvent(
      {required this.products,
      required this.paymentMode,
      required this.address});

  @override
  List<Object> get props => [products, address, paymentMode];
}

//! FETCH USER ORDERS EVENT
class FetchUserOrdersEvent extends OrderEvent {}

//! UPDATE ORDERSTATUS EVENT
class UpdateOrderStatusEvent extends OrderEvent {
  final String orderId;
  final OrderStatus newStatus;

  UpdateOrderStatusEvent({required this.orderId, required this.newStatus});

  @override
  List<Object> get props => [orderId, newStatus];
}
