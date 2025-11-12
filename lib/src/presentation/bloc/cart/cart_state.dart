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

class PaymentInitial extends CartState {}

class PaymentLoading extends CartState {}

class PaymentSuccess extends CartState {}

class PaymentFailure extends CartState {
  final String message;
  PaymentFailure(this.message);
}
