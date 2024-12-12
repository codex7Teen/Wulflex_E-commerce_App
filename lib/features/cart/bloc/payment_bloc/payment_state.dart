part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  final bool isCashOnDeliverySelected;
  final bool isRazorpaySelected;
  const PaymentState(
      {this.isCashOnDeliverySelected = false, this.isRazorpaySelected = false});

  @override
  List<Object> get props => [isCashOnDeliverySelected, isRazorpaySelected];
}

final class PaymentInitial extends PaymentState {}

final class PaymentUpdatedState extends PaymentState {
  const PaymentUpdatedState(
      {required super.isCashOnDeliverySelected,
      required super.isRazorpaySelected});
}
