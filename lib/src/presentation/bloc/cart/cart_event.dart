abstract class CartEvent {}

class LoadCart extends CartEvent {}

class RemoveFromCart extends CartEvent {
  final int productId;
  RemoveFromCart(this.productId);
}

class ProcessPaymentEvent extends CartEvent {}
