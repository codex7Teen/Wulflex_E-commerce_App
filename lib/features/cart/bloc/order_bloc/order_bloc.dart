import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        final newOrder = await orderServices.createOrder(
            products: event.products,
            address: event.address,
            totalAmount: event.totalAmount,
            paymentMode: event.paymentMode);
        emit(OrderCreated());
        log('BLOC: ORDER CREATED');
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
  }
}