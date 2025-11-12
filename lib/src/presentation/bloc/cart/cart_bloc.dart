import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppywell/src/domain/usecases/cart_usecase.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_event.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecase _cartUsecase = CartUsecase();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final products = await _cartUsecase.getCartProducts();
      if (products.isEmpty) {
        emit(CartEmpty());
      } else {
        final totalAmount = products.fold<double>(0, (sum, product) => sum + (product.salePrice??0));
        final totalItems = products.length;
        emit(CartLoaded(
          products: products,
          totalAmount: totalAmount,
          totalItems: totalItems,
        ));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }


  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(CartError('Please login to remove from cart'));
        return;
      }

      await _cartUsecase.removeFromCart(user.uid, event.productId);
      
      // Reload cart after removing
      final products = await _cartUsecase.getCartProducts();
      if (products.isEmpty) {
        emit(CartEmpty());
      } else {
        final totalAmount = products.fold<double>(0, (sum, product) => sum + (product.salePrice ?? 0));
        final totalItems = products.length;
        emit(CartLoaded(
          products: products,
          totalAmount: totalAmount,
          totalItems: totalItems,
        ));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

}

class PaymentBloc extends Bloc<CartEvent, CartState> {
  final CartUsecase _cartUsecase = CartUsecase();
  
  PaymentBloc() : super(PaymentInitial()) {
    on<ProcessPaymentEvent>(_onProcessPayment);
  }
  
  Future<void> _onProcessPayment(
    ProcessPaymentEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      await _cartUsecase.stripeMakePayment();
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}