// Events
abstract class PaymentEvent {}

class ProcessPaymentEvent extends PaymentEvent {
  // final Order order;
  ProcessPaymentEvent();
}
