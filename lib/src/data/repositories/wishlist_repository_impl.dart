import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getWishlistProducts(String userId) async {
    try {
      // Get user's wishlist product IDs
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      final wishlistIds = List<String>.from(userData['wishlist'] ?? []);

      if (wishlistIds.isEmpty) {
        return [];
      }

      // Fetch products using the wishlist IDs
      final products = <Product>[];
      for (final productId in wishlistIds) {
        try {
          final productDoc = await _firestore.collection('products').doc(productId).get();
          if (productDoc.exists) {
            final productData = productDoc.data() as Map<String, dynamic>;
            final product = Product.fromMap(productData, productId);
            products.add(product);
          }
        } catch (e) {
          // Skip products that can't be fetched
          print('Error fetching product $productId: $e');
        }
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch wishlist products: $e');
    }
  }

  @override
  Future<void> addToWishlist(String userId, String productId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'wishlist': FieldValue.arrayUnion([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  @override
  Future<void> removeFromWishlist(String userId, String productId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'wishlist': FieldValue.arrayRemove([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  @override
  Future<void> clearWishlist(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'wishlist': [],
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to clear wishlist: $e');
    }
  }
} 