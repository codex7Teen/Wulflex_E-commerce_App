import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    //! Select cod state
    on<SelectCashOnDeliveryEvent>((event, emit) {
      emit(PaymentUpdatedState(
          isCashOnDeliverySelected: true, isRazorpaySelected: false));
    });

    //! Select razorpay state
    on<SelectRazorpayEvent>((event, emit) {
      emit(PaymentUpdatedState(
          isCashOnDeliverySelected: false, isRazorpaySelected: true));
    });
  }
}
