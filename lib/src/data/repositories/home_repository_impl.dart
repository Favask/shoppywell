import 'package:cloud_firestore/cloud_firestore.dart';
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

  HomeRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _firestore
          .collection('categories')
          .where('isActive', isEqualTo: true)
          .orderBy('sortOrder')
          .get();


      return snapshot.docs
          .map((doc) => CategoryModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .limit(10)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getTrendingProducts() async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .where('isTrending', isEqualTo: true)
          .limit(10)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .where('categoryId', isEqualTo: categoryId)
          .limit(20)
          .get();


      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AppBanner>> getActiveBanners() async {
    try {
      final snapshot = await _firestore
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .orderBy('sortOrder')
          .get();

      return snapshot.docs
          .map((doc) => AppBannerModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

} 