import 'package:equatable/equatable.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import '../../../domain/entities/app_banner.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/deal.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
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
  final List<Product> trendingProducts;
  final List<AppBanner> banners;
  final List<Deal> deals;
  final String? selectedCategoryId;
  final bool hasReachedMax;

  const HomeLoaded({
    required this.categories,
    required this.featuredProducts,
    required this.trendingProducts,
    required this.banners,
    required this.deals,
    this.selectedCategoryId,
    this.hasReachedMax = false,
  });

  HomeLoaded copyWith({
    List<Category>? categories,
    List<Product>? featuredProducts,
    List<Product>? trendingProducts,
    List<AppBanner>? banners,
    List<Deal>? deals,
    String? selectedCategoryId,
    bool? hasReachedMax,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      trendingProducts: trendingProducts ?? this.trendingProducts,
      banners: banners ?? this.banners,
      deals: deals ?? this.deals,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        featuredProducts,
        trendingProducts,
        banners,
        deals,
        selectedCategoryId,
        hasReachedMax,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
} 