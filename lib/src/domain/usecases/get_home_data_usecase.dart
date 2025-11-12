import '../entities/home_data.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository repository;

  GetHomeDataUsecase({required this.repository});

  Future<HomeData> call() async {
    final categories = await repository.getCategories();
    final featuredProducts = await repository.getFeaturedProducts();
    final banners = await repository.getActiveBanners();
    return HomeData(
      categories: categories,
      featuredProducts: featuredProducts,
      banners: banners,
    );
  }
} 