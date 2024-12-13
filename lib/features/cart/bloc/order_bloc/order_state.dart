part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrdersLoaded extends OrderState {
  final List<OrderModel> orders;

  OrdersLoaded({required this.orders});
}

final class OrderCreated extends OrderState {}

final class OrderError extends OrderState {
  final String errorMessage;

  OrderError({required this.errorMessage});
}
