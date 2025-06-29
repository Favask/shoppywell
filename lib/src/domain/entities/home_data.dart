import 'package:equatable/equatable.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'app_banner.dart';
import 'category.dart';
import 'deal.dart';

class HomeData extends Equatable {
  final List<Category> categories;
  final List<Product> featuredProducts;
  final List<Product> trendingProducts;
  final List<AppBanner> banners;
  final List<Deal> deals;

  const HomeData({
    required this.categories,
    required this.featuredProducts,
    required this.trendingProducts,
    required this.banners,
    required this.deals,
  });

  @override
  List<Object?> get props => [
        categories,
        featuredProducts,
        trendingProducts,
        banners,
        deals,
      ];
} 