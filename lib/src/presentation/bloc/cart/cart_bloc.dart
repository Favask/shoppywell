import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppywell/src/domain/usecase/cart.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_event.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  
  CartUseCAse useCase= CartUseCAse();
  PaymentBloc() : super(PaymentInitial()) {
    on<ProcessPaymentEvent>(_onProcessPayment);
  }
  
  Future<void> _onProcessPayment(
    ProcessPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final success = await useCase.stripeMakePayment();
      // if (success) {
      //   emit(PaymentSuccess());
      // } else {
      //   emit(PaymentFailure('Payment was not successful'));
      // }
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}