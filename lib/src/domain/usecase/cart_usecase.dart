import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/cart_repository.dart';
import 'package:shoppywell/src/data/repositories/cart_repository_impl.dart';

class CartUsecase {
  final CartRepository _repository = CartRepositoryImpl();

  Future<String> getUserId(String uid) {
    return _repository.getUserId(uid);
  }

  Future<List<Product>> getCartProducts(String userId) {
    return _repository.getCartProducts(userId);
  }

  Future<void> addToCart(String userId, String productId, int quantity, {String? size, String? color}) {
    return _repository.addToCart(userId, productId, quantity, size: size, color: color);
  }

  Future<void> removeFromCart(String userId, String productId) {
    return _repository.removeFromCart(userId, productId);
  }

  Future<void> updateCartItemQuantity(String userId, String productId, int quantity) {
    return _repository.updateCartItemQuantity(userId, productId, quantity);
  }

  Future<void> clearCart(String userId) {
    return _repository.clearCart(userId);
  }

  Future<void> stripeMakePayment() {
    return _repository.stripeMakePayment();
  }
} 