import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../domain/entities/app_banner.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/deal.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/app_banner_model.dart';
import '../models/category_model.dart';
import '../models/deal_model.dart';
import '../models/product_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseFirestore _firestore;
  final _logger = Logger();

  HomeRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Category>> getCategories() async {
    _logger.d('Fetching categories from Firestore...');
    try {
      final snapshot = await _firestore
          .collection('categories')
          .where('isActive', isEqualTo: true)
          .orderBy('sortOrder')
          .get();

      _logger.d('Fetched ${snapshot.docs.length} categories');
      return snapshot.docs
          .map((doc) => CategoryModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stacktrace) {
      _logger.e('Error fetching categories:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    _logger.d('Fetching featured products from Firestore...');
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .limit(10)
          .get();

      _logger.d('Fetched ${snapshot.docs.length} featured products');
      return snapshot.docs
          .map((doc) => ProductModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stacktrace) {
      _logger.e('Error fetching featured products:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<List<Product>> getTrendingProducts() async {
    _logger.d('Fetching trending products from Firestore...');
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .where('isTrending', isEqualTo: true)
          .limit(10)
          .get();

      _logger.d('Fetched ${snapshot.docs.length} trending products');
      return snapshot.docs
          .map((doc) => ProductModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stacktrace) {
      _logger.e('Error fetching trending products:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    _logger.d('Fetching products for category $categoryId from Firestore...');
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .where('categoryId', isEqualTo: categoryId)
          .limit(20)
          .get();

      _logger.d('Fetched ${snapshot.docs.length} products for category $categoryId');
      return snapshot.docs
          .map((doc) => ProductModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stacktrace) {
      _logger.e('Error fetching products for category $categoryId:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<List<AppBanner>> getActiveBanners() async {
    _logger.d('Fetching active banners from Firestore...');
    try {
      final snapshot = await _firestore
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .orderBy('sortOrder')
          .get();

      _logger.d('Fetched ${snapshot.docs.length} active banners');
      return snapshot.docs
          .map((doc) => AppBannerModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stacktrace) {
      _logger.e('Error fetching active banners:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<List<Deal>> getActiveDeals() async {
    _logger.d('Fetching active deals from Firestore...');
    try {
      final now = Timestamp.now();
      final snapshot = await _firestore
          .collection('deals')
          .where('isActive', isEqualTo: true)
          .where('endTime', isGreaterThan: now)
          .orderBy('endTime')
          .limit(5)
          .get();

      _logger.d('Fetched ${snapshot.docs.length} active deals');
      return snapshot.docs
          .map((doc) => DealModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e, stacktrace) {
      _logger.e('Error fetching active deals:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Stream<List<Product>> getProductsStream() {
    _logger.d('Setting up products stream from Firestore...');
    try {
      return _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
            _logger.d('Received ${snapshot.docs.length} products from stream');
            return snapshot.docs
              .map((doc) => ProductModel.fromJson({...doc.data(), 'id': doc.id}))
              .toList();
          });
    } catch (e, stacktrace) {
      _logger.e('Error setting up products stream:', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }
} 