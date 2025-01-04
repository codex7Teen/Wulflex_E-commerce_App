import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    //! Select cod state
    on<SelectCashOnDeliveryEvent>((event, emit) {
      emit(const PaymentUpdatedState(
          isCashOnDeliverySelected: true, isRazorpaySelected: false));
    });

    //! Select razorpay state
    on<SelectRazorpayEvent>((event, emit) {
      emit(const PaymentUpdatedState(
          isCashOnDeliverySelected: false, isRazorpaySelected: true));
    });
  }
}
