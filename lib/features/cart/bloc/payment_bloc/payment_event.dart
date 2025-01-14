part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class SelectCashOnDeliveryEvent extends PaymentEvent {}

class SelectRazorpayEvent extends PaymentEvent {}

class RazorpaySuccessEvent extends PaymentEvent {}

class RazorpayErrorEvent extends PaymentEvent {}
