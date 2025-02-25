import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/models/order_model.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/data/services/order_services.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderServices orderServices;
  OrderBloc(this.orderServices) : super(OrderInitial()) {
    //! CREATE ORDER BLOC
    on<CreateOrderEvent>((event, emit) async {
      try {
        emit(OrderLoading());
        final newOrders = await orderServices.createMultipleOrders(
            products: event.products,
            address: event.address,
            paymentMode: event.paymentMode);
        emit(OrderCreated(orders: newOrders));
        log('BLOC: ORDER CREATED: ${newOrders.length} order');
      } catch (error) {
        emit(OrderError(errorMessage: error.toString()));
      }
    });

    //! GET USER ORDERS EVENT
    on<FetchUserOrdersEvent>((event, emit) async {
      try {
        emit(OrderLoading());
        final orders = await orderServices.fetchUserOrders();
        emit(OrdersLoaded(orders: orders));
      } catch (error) {
        emit(OrderError(errorMessage: error.toString()));
      }
    });

    //! UPDATE ORDER STATUS
    on<UpdateOrderStatusEvent>((event, emit) async {
      try {
        emit(OrderLoading());
        await orderServices.updateOrderStatus(
            orderId: event.orderId, newStatus: event.newStatus);

        // Reflect all orders to get updated list
        final orders = await orderServices.fetchUserOrders();
        // First emit the success state
        emit(OrderUpdateSuccess());
        emit(OrdersLoaded(orders: orders));
      } catch (error) {
        emit(OrderError(errorMessage: error.toString()));
      }
    });
  }
}
