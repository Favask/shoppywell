
import 'package:shoppywell/src/data/models/product_model.dart';

abstract class CartRepository {
  Future<String> getUserId(String uid);
  Future<List<Product>> getCartProducts();
  Future<void> addToCart(String userId, int productId, int quantity, {String? size, String? color});
  Future<void> removeFromCart(String userId, int productId);
  Future<void> stripeMakePayment();
  Future<void> createPaymentIntent(String amount, String currency);
  Future<void> displayPaymentSheet();

} 