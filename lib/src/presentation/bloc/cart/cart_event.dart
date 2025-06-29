// Events
abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final String productId;
  final int quantity;
  final String? size;
  final String? color;
  
  AddToCart({
    required this.productId,
    this.quantity = 1,
    this.size,
    this.color,
  });
}

class RemoveFromCart extends CartEvent {
  final String productId;
  
  RemoveFromCart(this.productId);
}

class UpdateCartItemQuantity extends CartEvent {
  final String productId;
  final int quantity;
  
  UpdateCartItemQuantity(this.productId, this.quantity);
}

class ClearCart extends CartEvent {}

// Payment Events
abstract class PaymentEvent {}

class ProcessPaymentEvent extends PaymentEvent {
  // final Order order;
  ProcessPaymentEvent();
}
