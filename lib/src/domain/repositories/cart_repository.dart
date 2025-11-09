
import 'package:shoppywell/src/data/models/product_model.dart';

abstract class CartRepository {
  Future<String> getUserId(String uid);
  Future<List<Product>> getCartProducts(String userId);
  Future<void> addToCart(String userId, String productId, int quantity, {String? size, String? color});
  Future<void> removeFromCart(String userId, String productId);
  Future<void> updateCartItemQuantity(String userId, String productId, int quantity);
  Future<void> clearCart(String userId);
  Future<void> stripeMakePayment();
} 