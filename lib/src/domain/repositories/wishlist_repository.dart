
import 'package:shoppywell/src/data/models/product_model.dart';

abstract class WishlistRepository {
  Future<List<Product>> getWishlistProducts(String userId);
  Future<void> addToWishlist(String userId, String productId);
  Future<void> removeFromWishlist(String userId, String productId);
  Future<void> clearWishlist(String userId);
} 