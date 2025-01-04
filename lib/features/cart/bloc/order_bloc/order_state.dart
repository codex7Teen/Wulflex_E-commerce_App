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

  const OrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

final class OrderCreated extends OrderState {
  final List<OrderModel> orders;

  const OrderCreated({required this.orders});
}

final class OrderError extends OrderState {
  final String errorMessage;

  const OrderError({required this.errorMessage});
}

//! ORDER STATUS UPDATE SUCCESS
final class OrderUpdateSuccess extends OrderState {}
