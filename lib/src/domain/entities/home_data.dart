import 'package:shoppywell/src/data/models/product_model.dart';
import 'app_banner.dart';
import 'category.dart';

class HomeData {
  final List<Category> categories;
  final List<Product> featuredProducts;
  final List<AppBanner> banners;

  const HomeData({
    required this.categories,
    required this.featuredProducts,
    required this.banners,
  });
}
