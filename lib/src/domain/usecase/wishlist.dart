import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/wishlist_repository.dart';
import 'package:shoppywell/src/data/repositories/wishlist_repository_impl.dart';

class WishlistUsecase {
  final WishlistRepository _repository = WishlistRepositoryImpl();

  Future<List<Product>> getWishlistProducts(String userId) {
    return _repository.getWishlistProducts(userId);
  }

  Future<void> addToWishlist(String userId, String productId) {
    return _repository.addToWishlist(userId, productId);
  }

  Future<void> removeFromWishlist(String userId, String productId) {
    return _repository.removeFromWishlist(userId, productId);
  }

  Future<void> clearWishlist(String userId) {
    return _repository.clearWishlist(userId);
  }
} 