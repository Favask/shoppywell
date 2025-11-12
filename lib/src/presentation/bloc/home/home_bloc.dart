import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/repositories/home_repository_impl.dart';
import 'package:shoppywell/src/domain/usecases/get_home_data_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

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

    on<LoadHomeData>(_onLoadProducts);
    on<LoadCart>(_onLoadCart);
   }

  Future<void> _onLoadProducts(
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
        banners: homeData.banners,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadCart(
      LoadCart event,
    Emitter<HomeState> emit,
  ) async {
  }
}