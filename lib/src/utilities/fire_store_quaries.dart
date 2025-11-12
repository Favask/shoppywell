// firestore_setup.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';



//1. This is the class that will be used to setup the firestore schema

// class FirestoreSetup {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Main setup function - call this once to initialize your database
//   static Future<void> setupFirestoreSchema() async {
//     try {
//       print('🚀 Setting up Firestore schema...');
      
//       await _createCategories();
//       await _createSampleProducts();
//       await _createBanners();
//       await _createDeals();
//       await _createSampleReviews();
      
//       print('✅ Firestore schema setup completed successfully!');
//     } catch (e) {
//       print('❌ Error setting up schema: $e');
//       rethrow;
//     }
//   }

//   // Create Categories Collection
//   static Future<void> _createCategories() async {
//     final categories = [
//       {
//         'name': 'Beauty',
//         'displayName': 'Beauty',
//         'icon': 'beauty-icon.png',
//         'isActive': true,
//         'sortOrder': 1,
//         'createdAt': FieldValue.serverTimestamp(),
//       },
//       {
//         'name': 'Fashion',
//         'displayName': 'Fashion',
//         'icon': 'fashion-icon.png',
//         'isActive': true,
//         'sortOrder': 2,
//         'createdAt': FieldValue.serverTimestamp(),
//       },
//       {
//         'name': 'Kids',
//         'displayName': 'Kids',
//         'icon': 'kids-icon.png',
//         'isActive': true,
//         'sortOrder': 3,
//         'createdAt': FieldValue.serverTimestamp(),
//       },
//       {
//         'name': 'Mens',
//         'displayName': "Men's",
//         'icon': 'mens-icon.png',
//         'isActive': true,
//         'sortOrder': 4,
//         'createdAt': FieldValue.serverTimestamp(),
//       },
//       {
//         'name': 'Womens',
//         'displayName': "Women's",
//         'icon': 'womens-icon.png',
//         'isActive': true,
//         'sortOrder': 5,
//         'createdAt': FieldValue.serverTimestamp(),
//       }
//     ];

//     final batch = _firestore.batch();
    
//     for (int i = 0; i < categories.length; i++) {
//       final categoryRef = _firestore.collection('categories').doc('category_$i');
//       batch.set(categoryRef, categories[i]);
//     }
    
//     await batch.commit();
//     print('✅ Categories created');
//   }

//   // Create Sample Products
//   static Future<void> _createSampleProducts() async {
//     final sampleProducts = [
//       {
//         'name': 'Women Printed Kurta',
//         'description': 'Lorem ipsum consectetur adipiscing elit, sed diam voluptua',
//         'brand': 'Brand Name',
//         'categoryId': 'category_4', // Women's category
//         'subCategory': 'ethnic-wear',
//         'originalPrice': 1500,
//         'salePrice': 1500,
//         'discountPercentage': 0,
//         'currency': 'INR',
//         'images': ['kurta1.jpg', 'kurta2.jpg'],
//         'thumbnailUrl': 'kurta-thumb.jpg',
//         'colors': ['Blue', 'Red', 'Green'],
//         'sizes': ['S', 'M', 'L', 'XL'],
//         'materials': ['Cotton', 'Silk'],
//         'features': ['Comfortable', 'Breathable', 'Easy Care'],
//         'stockQuantity': 50,
//         'isInStock': true,
//         'rating': 4.2,
//         'reviewCount': 45,
//         'tags': ['kurta', 'ethnic', 'women', 'printed'],
//         'isActive': true,
//         'isFeatured': true,
//         'isTrending': false,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//         'slug': 'women-printed-kurta',
//         'metaDescription': 'Beautiful printed kurta for women'
//       },
//       {
//         'name': 'HRX by Hrithik Roshan',
//         'description': 'Lorem ipsum consectetur adipiscing elit, sed diam voluptua',
//         'brand': 'HRX',
//         'categoryId': 'category_3', // Men's category
//         'subCategory': 'footwear',
//         'originalPrice': 2499,
//         'salePrice': 2499,
//         'discountPercentage': 0,
//         'currency': 'INR',
//         'images': ['hrx-shoe1.jpg', 'hrx-shoe2.jpg'],
//         'thumbnailUrl': 'hrx-shoe-thumb.jpg',
//         'colors': ['Black', 'White', 'Red'],
//         'sizes': ['7', '8', '9', '10', '11'],
//         'materials': ['Synthetic', 'Rubber'],
//         'features': ['Lightweight', 'Durable', 'Non-slip'],
//         'stockQuantity': 30,
//         'isInStock': true,
//         'rating': 4.5,
//         'reviewCount': 128,
//         'tags': ['shoes', 'sports', 'hrithik', 'men'],
//         'isActive': true,
//         'isFeatured': false,
//         'isTrending': true,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//         'slug': 'hrx-hrithik-roshan-shoes',
//         'metaDescription': 'Premium sports shoes by HRX'
//       },
//       {
//         'name': 'IWC Schaffhausen IW391 Pilot Watch',
//         'description': 'Swiss luxury watch with automatic movement',
//         'brand': 'IWC',
//         'categoryId': 'category_3', // Men's category
//         'subCategory': 'watches',
//         'originalPrice': 750000,
//         'salePrice': 695000,
//         'discountPercentage': 7,
//         'currency': 'INR',
//         'images': ['iwc-watch1.jpg', 'iwc-watch2.jpg'],
//         'thumbnailUrl': 'iwc-watch-thumb.jpg',
//         'colors': ['Black', 'Silver'],
//         'sizes': ['44mm'],
//         'materials': ['Steel', 'Leather'],
//         'features': ['Automatic', 'Water Resistant', 'Swiss Made'],
//         'stockQuantity': 5,
//         'isInStock': true,
//         'rating': 4.8,
//         'reviewCount': 23,
//         'tags': ['watch', 'luxury', 'swiss', 'pilot'],
//         'isActive': true,
//         'isFeatured': true,
//         'isTrending': true,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//         'slug': 'iwc-pilot-watch-iw391',
//         'metaDescription': 'Luxury Swiss pilot watch by IWC'
//       },
//       {
//         'name': 'Labbin White Sneakers',
//         'description': 'Comfortable white sneakers for men and women',
//         'brand': 'Labbin',
//         'categoryId': 'category_1', // Fashion category
//         'subCategory': 'footwear',
//         'originalPrice': 2650,
//         'salePrice': 2650,
//         'discountPercentage': 0,
//         'currency': 'INR',
//         'images': ['labbin-sneaker1.jpg', 'labbin-sneaker2.jpg'],
//         'thumbnailUrl': 'labbin-sneaker-thumb.jpg',
//         'colors': ['White', 'Off-White'],
//         'sizes': ['6', '7', '8', '9', '10', '11'],
//         'materials': ['Canvas', 'Rubber'],
//         'features': ['Comfortable', 'Casual', 'Unisex'],
//         'stockQuantity': 40,
//         'isInStock': true,
//         'rating': 4.3,
//         'reviewCount': 67,
//         'tags': ['sneakers', 'white', 'casual', 'unisex'],
//         'isActive': true,
//         'isFeatured': false,
//         'isTrending': true,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//         'slug': 'labbin-white-sneakers',
//         'metaDescription': 'Stylish white sneakers for everyday wear'
//       }
//     ];

//     final batch = _firestore.batch();
    
//     for (int i = 0; i < sampleProducts.length; i++) {
//       final productRef = _firestore.collection('products').doc('product_$i');
//       batch.set(productRef, sampleProducts[i]);
//     }
    
//     await batch.commit();
//     print('✅ Sample products created');
//   }

//   // Create Banners
//   static Future<void> _createBanners() async {
//     final banners = [
//       {
//         'title': '50-60% OFF',
//         'subtitle': 'Now in (product) All colours',
//         'imageUrl': 'banner-shopping.jpg',
//         'ctaText': 'Shop Now',
//         'ctaLink': '/categories/fashion',
//         'backgroundColor': '#FF69B4',
//         'textColor': '#FFFFFF',
//         'isActive': true,
//         'startDate': FieldValue.serverTimestamp(),
//         'endDate': Timestamp.fromDate(DateTime.now().add(const Duration(days: 30))),
//         'sortOrder': 1,
//         'targetCategories': ['fashion', 'womens'],
//         'targetUserTypes': ['all']
//       },
//       {
//         'title': 'Hot Summer Sale',
//         'subtitle': 'Special Offers on trending products',
//         'imageUrl': 'summer-sale-banner.jpg',
//         'ctaText': 'Shop Now',
//         'ctaLink': '/deals',
//         'backgroundColor': '#FF6B35',
//         'textColor': '#FFFFFF',
//         'isActive': true,
//         'startDate': FieldValue.serverTimestamp(),
//         'endDate': Timestamp.fromDate(DateTime.now().add(const Duration(days: 15))),
//         'sortOrder': 2,
//         'targetCategories': ['all'],
//         'targetUserTypes': ['all']
//       }
//     ];

//     final batch = _firestore.batch();
    
//     for (int i = 0; i < banners.length; i++) {
//       final bannerRef = _firestore.collection('banners').doc('banner_$i');
//       batch.set(bannerRef, banners[i]);
//     }
    
//     await batch.commit();
//     print('✅ Banners created');
//   }

//   // Create Deals
//   static Future<void> _createDeals() async {
//     final now = DateTime.now();
//     final todayStart = DateTime(now.year, now.month, now.day);
//     final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

//     final deals = [
//       {
//         'title': 'Deal of the Day',
//         'type': 'daily',
//         'productIds': ['product_0', 'product_1'], // Kurta and HRX shoes
//         'discountPercentage': 25,
//         'startTime': Timestamp.fromDate(todayStart),
//         'endTime': Timestamp.fromDate(todayEnd),
//         'isActive': true,
//         'badgeText': '25% OFF',
//         'priority': 1
//       },
//       {
//         'title': 'Flash Sale',
//         'type': 'flash',
//         'productIds': ['product_2', 'product_3'], // Watch and Sneakers
//         'discountPercentage': 15,
//         'startTime': Timestamp.fromDate(now),
//         'endTime': Timestamp.fromDate(now.add(const Duration(hours: 6))),
//         'isActive': true,
//         'badgeText': '15% OFF',
//         'priority': 2
//       }
//     ];

//     final batch = _firestore.batch();
    
//     for (int i = 0; i < deals.length; i++) {
//       final dealRef = _firestore.collection('deals').doc('deal_$i');
//       batch.set(dealRef, deals[i]);
//     }
    
//     await batch.commit();
//     print('✅ Deals created');
//   }

//   // Create Sample Reviews
//   static Future<void> _createSampleReviews() async {
//     final reviews = [
//       {
//         'productId': 'product_0', // Women Kurta
//         'userId': 'user_001',
//         'userName': 'Sarah Johnson',
//         'userPhoto': 'user1.jpg',
//         'rating': 4,
//         'title': 'Great quality kurta',
//         'comment': 'Love the fabric and fit. Perfect for casual wear. The colors are vibrant and true to the pictures.',
//         'images': <String>[],
//         'isVerifiedPurchase': true,
//         'isHelpful': 12,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp()
//       },
//       {
//         'productId': 'product_1', // HRX Shoes
//         'userId': 'user_002',
//         'userName': 'Mike Chen',
//         'userPhoto': 'user2.jpg',
//         'rating': 5,
//         'title': 'Excellent shoes!',
//         'comment': 'Very comfortable and stylish. Great for workouts and casual wear. Highly recommend!',
//         'images': ['review-shoe1.jpg'],
//         'isVerifiedPurchase': true,
//         'isHelpful': 8,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp()
//       },
//       {
//         'productId': 'product_2', // IWC Watch
//         'userId': 'user_003',
//         'userName': 'David Smith',
//         'userPhoto': 'user3.jpg',
//         'rating': 5,
//         'title': 'Luxury at its finest',
//         'comment': 'Absolutely stunning watch. The craftsmanship is exceptional and it keeps perfect time.',
//         'images': <String>[],
//         'isVerifiedPurchase': true,
//         'isHelpful': 25,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp()
//       },
//       {
//         'productId': 'product_3', // Labbin Sneakers
//         'userId': 'user_004',
//         'userName': 'Emma Wilson',
//         'userPhoto': 'user4.jpg',
//         'rating': 4,
//         'title': 'Comfortable daily wear',
//         'comment': 'Perfect for everyday use. Very comfortable and goes with most outfits.',
//         'images': <String>[],
//         'isVerifiedPurchase': true,
//         'isHelpful': 6,
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp()
//       }
//     ];

//     final batch = _firestore.batch();
    
//     for (int i = 0; i < reviews.length; i++) {
//       final reviewRef = _firestore.collection('reviews').doc('review_$i');
//       batch.set(reviewRef, reviews[i]);
//     }
    
//     await batch.commit();
//     print('✅ Sample reviews created');
//   }

//   // Helper method to create a sample user (call this separately if needed)
//   static Future<void> createSampleUser(String userId) async {
//     final userData = {
//       'email': 'user@example.com',
//       'displayName': 'Sample User',
//       'photoURL': 'default-avatar.jpg',
//       'createdAt': FieldValue.serverTimestamp(),
//       'lastLoginAt': FieldValue.serverTimestamp(),
//       'wishlist': <String>[],
//       'cart': <Map<String, dynamic>>[],
//       'addresses': <Map<String, dynamic>>[],
//       'preferences': {
//         'categories': <String>[],
//         'priceRange': {'min': 0, 'max': 10000}
//       }
//     };

//     await _firestore.collection('users').doc(userId).set(userData);
//     print('✅ Sample user created: $userId');
//   }

//   // Method to add a single product (for testing individual additions)
//   static Future<void> addSingleProduct({
//     required String name,
//     required String description,
//     required String brand,
//     required String categoryId,
//     required double originalPrice,
//     required double salePrice,
//     required List<String> images,
//     required List<String> colors,
//     required List<String> sizes,
//     required int stockQuantity,
//     required List<String> tags,
//     bool isFeatured = false,
//     bool isTrending = false,
//   }) async {
//     final productData = {
//       'name': name,
//       'description': description,
//       'brand': brand,
//       'categoryId': categoryId,
//       'subCategory': '',
//       'originalPrice': originalPrice,
//       'salePrice': salePrice,
//       'discountPercentage': ((originalPrice - salePrice) / originalPrice * 100).round(),
//       'currency': 'INR',
//       'images': images,
//       'thumbnailUrl': images.isNotEmpty ? images.first : '',
//       'colors': colors,
//       'sizes': sizes,
//       'materials': <String>[],
//       'features': <String>[],
//       'stockQuantity': stockQuantity,
//       'isInStock': stockQuantity > 0,
//       'rating': 0.0,
//       'reviewCount': 0,
//       'tags': tags,
//       'isActive': true,
//       'isFeatured': isFeatured,
//       'isTrending': isTrending,
//       'createdAt': FieldValue.serverTimestamp(),
//       'updatedAt': FieldValue.serverTimestamp(),
//       'slug': name.toLowerCase().replaceAll(' ', '-'),
//       'metaDescription': description
//     };

//     await _firestore.collection('products').add(productData);
//     print('✅ Product added: $name');
//   }

//   // Method to check if schema already exists
//   static Future<bool> isSchemaSetup() async {
//     try {
//       final categoriesSnapshot = await _firestore.collection('categories').limit(1).get();
//       final productsSnapshot = await _firestore.collection('products').limit(1).get();
      
//       return categoriesSnapshot.docs.isNotEmpty && productsSnapshot.docs.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }

//   // Method to clear all collections (use with caution!)
//   static Future<void> clearAllCollections() async {
//     if (kDebugMode) {
//       final collections = ['categories', 'products', 'banners', 'deals', 'reviews'];
      
//       for (String collectionName in collections) {
//         final snapshot = await _firestore.collection(collectionName).get();
//         final batch = _firestore.batch();
        
//         for (var doc in snapshot.docs) {
//           batch.delete(doc.reference);
//         }
        
//         await batch.commit();
//         print('✅ Cleared collection: $collectionName');
//       }
//     } else {
//       print('⚠️ Clear collections only available in debug mode');
//     }
//   }
// }





// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collection = 'users';
//
//   // Create user document
//   Future<void> createUser({
//     required String uid,
//     required String email,
//     required String displayName,
//     String? phoneNumber,
//     String? profileImageUrl,
//   }) async {
//     try {
//       final userData = {
//         'uid': uid,
//         'email': email,
//         'displayName': displayName,
//         'phoneNumber': phoneNumber ?? '',
//         'profileImageUrl': profileImageUrl ?? '',
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//         'isActive': true,
//         'addresses': <Map<String, dynamic>>[],
//         'wishlist': <String>[],
//         'cart': <Map<String, dynamic>>[],
//         'orderHistory': <String>[],
//         'loyaltyPoints': 0,
//         'preferences': {
//           'categories': <String>[],
//           'brands': <String>[],
//           'priceRange': {
//             'min': 0,
//             'max': 10000,
//           },
//           'notifications': {
//             'orderUpdates': true,
//             'promotions': true,
//             'newArrivals': false,
//           }
//         },
//         'paymentMethods': <String>[],
//       };
//
//       await _firestore.collection(_collection).doc(uid).set(userData);
//       print('User created successfully: $uid');
//     } catch (e) {
//       print('Error creating user: $e');
//       rethrow;
//     }
//   }
//
//   // Create sample users for testing
//   Future<void> createSampleUsers() async {
//     final sampleUsers = [
//       {
//         'uid': 'user_001',
//         'email': 'john.doe@example.com',
//         'displayName': 'John Doe',
//         'phoneNumber': '+1234567890',
//         'profileImageUrl': 'https://example.com/avatar1.jpg',
//         'addresses': [
//           {
//             'id': 'addr_001',
//             'type': 'home',
//             'name': 'John Doe',
//             'street': '123 Main Street',
//             'city': 'New York',
//             'state': 'NY',
//             'zipCode': '10001',
//             'country': 'USA',
//             'isDefault': true,
//           }
//         ],
//         'wishlist': ['prod_001', 'prod_005', 'prod_012'],
//         'cart': [
//           {
//             'productId': 'prod_003',
//             'quantity': 2,
//             'price': 29.99,
//             'addedAt': Timestamp.now(),
//           }
//         ],
//         'orderHistory': ['order_001', 'order_002'],
//         'loyaltyPoints': 150,
//         'preferences': {
//           'categories': ['electronics', 'books'],
//           'brands': ['apple', 'samsung'],
//           'priceRange': {'min': 0, 'max': 1000},
//           'notifications': {
//             'orderUpdates': true,
//             'promotions': true,
//             'newArrivals': true,
//           }
//         }
//       },
//       {
//         'uid': 'user_002',
//         'email': 'jane.smith@example.com',
//         'displayName': 'Jane Smith',
//         'phoneNumber': '+1987654321',
//         'profileImageUrl': 'https://example.com/avatar2.jpg',
//         'addresses': [
//           {
//             'id': 'addr_002',
//             'type': 'home',
//             'name': 'Jane Smith',
//             'street': '456 Oak Avenue',
//             'city': 'Los Angeles',
//             'state': 'CA',
//             'zipCode': '90210',
//             'country': 'USA',
//             'isDefault': true,
//           },
//           {
//             'id': 'addr_003',
//             'type': 'work',
//             'name': 'Jane Smith',
//             'street': '789 Business Blvd',
//             'city': 'Los Angeles',
//             'state': 'CA',
//             'zipCode': '90211',
//             'country': 'USA',
//             'isDefault': false,
//           }
//         ],
//         'wishlist': ['prod_007', 'prod_015'],
//         'cart': [],
//         'orderHistory': ['order_003'],
//         'loyaltyPoints': 75,
//         'preferences': {
//           'categories': ['fashion', 'beauty'],
//           'brands': ['nike', 'adidas'],
//           'priceRange': {'min': 10, 'max': 500},
//           'notifications': {
//             'orderUpdates': true,
//             'promotions': false,
//             'newArrivals': true,
//           }
//         }
//       }
//     ];
//
//     for (var userData in sampleUsers) {
//       try {
//         final userDoc = {
//           ...userData,
//           'createdAt': FieldValue.serverTimestamp(),
//           'updatedAt': FieldValue.serverTimestamp(),
//           'isActive': true,
//           'paymentMethods': <String>[],
//         };
//
//         await _firestore
//             .collection(_collection)
//             .doc(userData['uid'] as String)
//             .set(userDoc);
//
//         print('Sample user created: ${userData['displayName']}');
//       } catch (e) {
//         print('Error creating sample user ${userData['displayName']}: $e');
//       }
//     }
//   }
//
//   // Get user by ID
//   Future<Map<String, dynamic>?> getUser(String uid) async {
//     try {
//       final doc = await _firestore.collection(_collection).doc(uid).get();
//       if (doc.exists) {
//         return doc.data();
//       }
//       return null;
//     } catch (e) {
//       print('Error getting user: $e');
//       rethrow;
//     }
//   }
//
//   // Update user profile
//   Future<void> updateUser(String uid, Map<String, dynamic> updates) async {
//     try {
//       updates['updatedAt'] = FieldValue.serverTimestamp();
//       await _firestore.collection(_collection).doc(uid).update(updates);
//       print('User updated successfully: $uid');
//     } catch (e) {
//       print('Error updating user: $e');
//       rethrow;
//     }
//   }
//
//   // Add address to user
//   Future<void> addAddress(String uid, Map<String, dynamic> address) async {
//     try {
//       await _firestore.collection(_collection).doc(uid).update({
//         'addresses': FieldValue.arrayUnion([address]),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//       print('Address added successfully');
//     } catch (e) {
//       print('Error adding address: $e');
//       rethrow;
//     }
//   }
//
//   // Add item to wishlist
//   Future<void> addToWishlist(String uid, String productId) async {
//     try {
//       await _firestore.collection(_collection).doc(uid).update({
//         'wishlist': FieldValue.arrayUnion([productId]),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//       print('Product added to wishlist');
//     } catch (e) {
//       print('Error adding to wishlist: $e');
//       rethrow;
//     }
//   }
//
//   // Add item to cart
//   Future<void> addToCart(String uid, Map<String, dynamic> cartItem) async {
//     try {
//       cartItem['addedAt'] = Timestamp.now();
//       await _firestore.collection(_collection).doc(uid).update({
//         'cart': FieldValue.arrayUnion([cartItem]),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//       print('Product added to cart');
//     } catch (e) {
//       print('Error adding to cart: $e');
//       rethrow;
//     }
//   }
//
//   // Update loyalty points
//   Future<void> updateLoyaltyPoints(String uid, int points) async {
//     try {
//       await _firestore.collection(_collection).doc(uid).update({
//         'loyaltyPoints': FieldValue.increment(points),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//       print('Loyalty points updated');
//     } catch (e) {
//       print('Error updating loyalty points: $e');
//       rethrow;
//     }
//   }
// }
//
// // Usage example
// void main() async {
//   final userService = UserService();
//
//   // Create a new user
//   await userService.createUser(
//     uid: 'user_123',
//     email: 'newuser@example.com',
//     displayName: 'New User',
//     phoneNumber: '+1122334455',
//   );
//
//   // Create sample users for testing
//   await userService.createSampleUsers();
//
//   // Add item to cart
//   await userService.addToCart('user_001', {
//     'productId': 'prod_999',
//     'quantity': 1,
//     'price': 49.99,
//   });
//
//   // Update loyalty points
//   await userService.updateLoyaltyPoints('user_001', 25);
// }