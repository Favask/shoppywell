
import 'package:shoppywell/src/data/models/product_model.dart';

import '../entities/app_banner.dart';
import '../entities/category.dart';
import '../entities/deal.dart';

abstract class HomeRepository {
  Future<List<Category>> getCategories();
  Future<List<Product>> getFeaturedProducts();
  Future<List<Product>> getTrendingProducts();
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<AppBanner>> getActiveBanners();
  Future<List<Deal>> getActiveDeals();
  Stream<List<Product>> getProductsStream();
} 