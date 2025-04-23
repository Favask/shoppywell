import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppywell/src/data/repository/product_detail_repo.dart';
import 'package:shoppywell/src/domain/usecase/product_detail.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUsecase useCase=ProductDetailUsecase();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
    on<AddToCart>(_onAddToCart);
    on<ChangeSizeSelection>(_onChangeSizeSelection);
    on<ChangeImageIndex>(_onChangeImageIndex);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    try {
      final product = await useCase.getProductById(event.productId);
      final similarProducts = await useCase.getSimilarProducts(
        product.name.split(' ')[
            0], // Using first word of title as category (you can modify this)
        product.id,
      );

      emit(ProductDetailLoaded(
        product: product,
        similarProducts: similarProducts,
        currentSizeIndex: 1, // Default size selection
        currentImageIndex: 0, // Default image index
      ));
    } catch (e) {
      print("---catch (e) -------$e");
      emit(ProductDetailError(e.toString()));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(AddToCartLoading());

      try {
        // Check if user is logged in
        // final user = _auth.currentUser;
        // if (user == null) {
        //   emit(AddToCartError('User not logged in'));
        //   emit(currentState); // Restore previous state
        //   return;
        // }

        // Add to cart in Firestore
        await useCase.addToCart(event.productId, "1"); //* userId hardcoded

        // // Update local state to reflect cart status
        final updatedProduct = currentState.product.copyWith(isInCart: true);

        emit(AddToCartSuccess());
        emit(currentState.copyWith(product: updatedProduct));
      } catch (e) {
        emit(AddToCartError(e.toString()));
        emit(currentState); // Restore previous state
      }
    }
  }

  void _onChangeSizeSelection(
    ChangeSizeSelection event,
    Emitter<ProductDetailState> emit,
  ) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(currentState.copyWith(currentSizeIndex: event.sizeIndex));
    }
  }

  void _onChangeImageIndex(
    ChangeImageIndex event,
    Emitter<ProductDetailState> emit,
  ) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(currentState.copyWith(currentImageIndex: event.imageIndex));
    }
  }
}
