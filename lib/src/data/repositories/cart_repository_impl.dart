import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getCartProducts(String userId) async {
    try {
      // Get user's cart product IDs
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      final cartIds = List<String>.from(userData['cart'] ?? []);

      if (cartIds.isEmpty) {
        return [];
      }

      // Fetch products using the cart IDs
      final products = <Product>[];
      for (final productId in cartIds) {
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
      throw Exception('Failed to fetch cart products: $e');
    }
  }

  @override
  Future<void> addToCart(String userId, String productId, int quantity, {String? size, String? color}) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'cart': FieldValue.arrayUnion([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'cart': FieldValue.arrayRemove([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  @override
  Future<void> updateCartItemQuantity(String userId, String productId, int quantity) async {
    // For now, we'll just add/remove the product based on quantity
    // In a more complex implementation, you might want to store quantity in the cart array
    if (quantity <= 0) {
      await removeFromCart(userId, productId);
    } else {
      // Remove first, then add the correct number of times
      await removeFromCart(userId, productId);
      for (int i = 0; i < quantity; i++) {
        await addToCart(userId, productId, 1);
      }
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'cart': [],
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Future<void> stripeMakePayment() async {
    // Implementation for Stripe payment
    // This would integrate with Stripe API
    throw UnimplementedError('Stripe payment not implemented yet');
  }
} 