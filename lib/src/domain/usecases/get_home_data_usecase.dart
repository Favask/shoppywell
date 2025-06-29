import '../entities/home_data.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository repository;

  GetHomeDataUsecase({required this.repository});

  Future<HomeData> call() async {
    final categories = await repository.getCategories();
    final featuredProducts = await repository.getFeaturedProducts();
    final trendingProducts = await repository.getTrendingProducts();
    final banners = await repository.getActiveBanners();
    final deals = await repository.getActiveDeals();

    return HomeData(
      categories: categories,
      featuredProducts: featuredProducts,
      trendingProducts: trendingProducts,
      banners: banners,
      deals: deals,
    );
  }
} 