
// Cart States
import 'package:shoppywell/src/data/models/product_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> products;
  final double totalAmount;
  final int totalItems;
  
  CartLoaded({
    required this.products,
    required this.totalAmount,
    required this.totalItems,
  });
}

class CartEmpty extends CartState {}

class CartError extends CartState {
  final String message;
  
  CartError(this.message);
}

// Payment States
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {}
class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);
}
