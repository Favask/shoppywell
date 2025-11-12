import 'package:shoppywell/src/data/models/product_model.dart';
import '../../../domain/entities/app_banner.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/deal.dart';

abstract class HomeState {
  const HomeState();

}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Product> featuredProducts;
  final List<AppBanner> banners;

  const HomeLoaded({
    required this.categories,
    required this.featuredProducts,
    required this.banners,
  });

  HomeLoaded copyWith({
    List<Category>? categories,
    List<Product>? featuredProducts,
    List<AppBanner>? banners,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      banners: banners ?? this.banners,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
