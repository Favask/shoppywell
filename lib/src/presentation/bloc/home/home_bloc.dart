import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_home_data_usecase.dart';
import '../../../data/repositories/home_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_event.dart';
import 'home_state.dart';
// Assuming a service locator is used, e.g., getIt
// import 'package:get_it/get_it.dart';
// final getIt = GetIt.instance;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final GetHomeDataUsecase _getHomeDataUsecase;

  // Modified constructor to remove GetHomeDataUsecase parameter
  HomeBloc() : super(const HomeInitial()) {
    // Resolve GetHomeDataUsecase dependency here
    // If using a DI container like GetIt, you would do:
    // _getHomeDataUsecase = getIt<GetHomeDataUsecase>();

    // If not using a DI container, instantiate dependencies directly:
    final firestore = FirebaseFirestore.instance;
    final repository = HomeRepositoryImpl(firestore: firestore);
    _getHomeDataUsecase = GetHomeDataUsecase(repository: repository);

    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      // Use the resolved _getHomeDataUsecase
      final homeData = await _getHomeDataUsecase();
      emit(HomeLoaded(
        categories: homeData.categories,
        featuredProducts: homeData.featuredProducts,
        trendingProducts: homeData.trendingProducts,
        banners: homeData.banners,
        deals: homeData.deals,
      ));
    } catch (e, stacktrace) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
     if (state is HomeLoaded) {
        emit((state as HomeLoaded).copyWith()); // Optionally show a refreshing indicator if needed
     }
    try {
      // Use the resolved _getHomeDataUsecase
      final homeData = await _getHomeDataUsecase();
      emit(HomeLoaded(
        categories: homeData.categories,
        featuredProducts: homeData.featuredProducts,
        trendingProducts: homeData.trendingProducts,
        banners: homeData.banners,
        deals: homeData.deals,
      ));
    } catch (e, stacktrace) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      if (currentState.hasReachedMax) {
         return;
      }

      try {
        // This part needs adjustment based on how pagination is implemented in the repository.
        // For now, it refetches all featured products which is not ideal for pagination.
        // You would typically pass a last document or offset to the repository.
        // Use the resolved _getHomeDataUsecase
        final homeData = await _getHomeDataUsecase(); // This fetches everything, not just more products

        // This logic for hasReachedMax and appending assumes the usecase fetches in chunks
        // and indicates if there are no more products. This needs to be aligned with the usecase/repository pagination logic.
        emit(currentState.copyWith(
          featuredProducts: [
            ...currentState.featuredProducts,
            ...homeData.featuredProducts,
          ],
          hasReachedMax: homeData.featuredProducts.isEmpty, // This logic is likely incorrect without proper pagination
        ));
      } catch (e, stacktrace) {
        emit(HomeError(e.toString()));
      }
    }
  }

  void _onSelectCategory(
    SelectCategory event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      // TODO: Implement fetching products by selected category if needed for the home page structure
      emit(currentState.copyWith(selectedCategoryId: event.categoryId));
    }
  }
} 