import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/repositories/review_repository_impl.dart';
import 'package:shoppywell/src/domain/usecase/product_detail.dart';
import 'package:shoppywell/src/domain/usecase/review_usecase.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUsecase useCase = ProductDetailUsecase();
  final ReviewUsecase reviewUsecase;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  DocumentSnapshot? _lastReviewDocument;
  static const int _reviewsPerPage = 10;

  ProductDetailBloc() 
      : reviewUsecase = ReviewUsecase(ReviewRepositoryImpl()),
        super(ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
    on<LoadProductReviews>(_onLoadProductReviews);
    on<LoadMoreReviews>(_onLoadMoreReviews);
    on<AddToCart>(_onAddToCart);
    on<BuyNow>(_onBuyNow);
    on<ChangeSizeSelection>(_onChangeSizeSelection);
    on<ChangeColorSelection>(_onChangeColorSelection);
    on<ChangeImageIndex>(_onChangeImageIndex);
    on<ChangeQuantity>(_onChangeQuantity);
    on<ToggleWishlist>(_onToggleWishlist);
    on<ShareProduct>(_onShareProduct);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    try {
      print("----event.productId-----------${event.productId}");
      final product = await useCase.getProductById(event.productId);
      // final similarProducts = await useCase.getSimilarProducts(
      //   product.name.split(' ')[0],
      //   product.id,
      // );
      
      // // Load initial reviews
      // final reviews = await reviewUsecase.getProductReviewsPaginated(
      //   event.productId,
      //   _reviewsPerPage,
      //   null,
      // );
      
      // final averageRating = await reviewUsecase.getAverageRating(event.productId);
      // final reviewCount = await reviewUsecase.getReviewCount(event.productId);

      emit(ProductDetailLoaded(
        product: product,
        similarProducts: [],
        reviews: [],
        currentSizeIndex: 0,
        currentImageIndex: 0,
        currentColorIndex: 0,
        quantity: 1,
        isLoadingReviews: false,
        hasMoreReviews: false,
        averageRating: 0,
        reviewCount: 0,
      ));
      
      // if (reviews.isNotEmpty) {
      //   _lastReviewDocument = await _firestore
      //       .collection('reviews')
      //       .doc(reviews.last.id)
      //       .get();
      // }
    } catch (e) {
      print("---catch (e) -------$e");
      emit(ProductDetailError(e.toString()));
    }
  }

  Future<void> _onLoadProductReviews(
    LoadProductReviews event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(currentState.copyWith(isLoadingReviews: true));
      
      try {
        final reviews = await reviewUsecase.getProductReviewsPaginated(
          event.productId,
          _reviewsPerPage,
          null,
        );
        
        if (reviews.isNotEmpty) {
          _lastReviewDocument = await _firestore
              .collection('reviews')
              .doc(reviews.last.id)
              .get();
        }
        
        emit(currentState.copyWith(
          reviews: reviews,
          isLoadingReviews: false,
          hasMoreReviews: reviews.length >= _reviewsPerPage,
        ));
      } catch (e) {
        emit(currentState.copyWith(isLoadingReviews: false));
        emit(ReviewsError(e.toString()));
      }
    }
  }

  Future<void> _onLoadMoreReviews(
    LoadMoreReviews event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded && currentState.hasMoreReviews) {
      emit(currentState.copyWith(isLoadingReviews: true));
      
      try {
        final moreReviews = await reviewUsecase.getProductReviewsPaginated(
          event.productId,
          _reviewsPerPage,
          _lastReviewDocument,
        );
        
        if (moreReviews.isNotEmpty) {
          _lastReviewDocument = await _firestore
              .collection('reviews')
              .doc(moreReviews.last.id)
              .get();
        }
        
        final allReviews = [...currentState.reviews, ...moreReviews];
        
        emit(currentState.copyWith(
          reviews: allReviews,
          isLoadingReviews: false,
          hasMoreReviews: moreReviews.length >= _reviewsPerPage,
        ));
      } catch (e) {
        emit(currentState.copyWith(isLoadingReviews: false));
        emit(ReviewsError(e.toString()));
      }
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
        final user = _auth.currentUser;
        // if (user == null) {
        //   emit(AddToCartError('Please login to add items to cart'));
        //   emit(currentState);
        //   return;
        // }

        // // Validate selections
        // if (event.selectedSize.isEmpty || event.selectedColor.isEmpty) {
        //   emit(AddToCartError('Please select size and color'));
        //   emit(currentState);
        //   return;
        // }

        // Add to cart in Firestore
        await useCase.addToCart(int.parse(event.productId), user?.email);

        emit(AddToCartSuccess());
        emit(currentState);
      } catch (e) {
        emit(AddToCartError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future<void> _onBuyNow(
    BuyNow event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      try {
        // Check if user is logged in
        final user = _auth.currentUser;
        if (user == null) {
          emit(AddToCartError('Please login to proceed'));
          emit(currentState);
          return;
        }

        // Validate selections
        if (event.selectedSize.isEmpty || event.selectedColor.isEmpty) {
          emit(AddToCartError('Please select size and color'));
          emit(currentState);
          return;
        }

        // Add to cart and navigate to checkout
        await useCase.addToCart(int.parse(event.productId), user.uid);
        
        // Here you would typically navigate to checkout
        emit(AddToCartSuccess());
        emit(currentState);
      } catch (e) {
        emit(AddToCartError(e.toString()));
        emit(currentState);
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

  void _onChangeColorSelection(
    ChangeColorSelection event,
    Emitter<ProductDetailState> emit,
  ) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(currentState.copyWith(currentColorIndex: event.colorIndex));
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

  void _onChangeQuantity(
    ChangeQuantity event,
    Emitter<ProductDetailState> emit,
  ) {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      // Use a reasonable max quantity since ProductModel doesn't have stockQuantity
      final maxQuantity = 10; // Default max quantity
      final newQuantity = event.quantity.clamp(1, maxQuantity);
      emit(currentState.copyWith(quantity: newQuantity));
    }
  }

  Future<void> _onToggleWishlist(
    ToggleWishlist event,
    Emitter<ProductDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      try {
        final user = _auth.currentUser;
        if (user == null) {
          emit(AddToCartError('Please login to add to wishlist'));
          emit(currentState);
          return;
        }

        // Toggle wishlist status in Firestore
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        final wishlist = List<String>.from(userDoc.data()?['wishlist'] ?? []);
        
        if (wishlist.contains(event.productId)) {
          wishlist.remove(event.productId);
        } else {
          wishlist.add(event.productId);
        }
        
        await _firestore.collection('users').doc(user.uid).update({
          'wishlist': wishlist,
        });
        
        emit(currentState);
      } catch (e) {
        emit(AddToCartError(e.toString()));
        emit(currentState);
      }
    }
  }

  void _onShareProduct(
    ShareProduct event,
    Emitter<ProductDetailState> emit,
  ) {
    // This would typically integrate with a sharing plugin
    // For now, we'll just emit the current state
    final currentState = state;
    if (currentState is ProductDetailLoaded) {
      emit(currentState);
    }
  }
}
