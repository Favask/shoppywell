
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/data/models/review_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductModel product;
  final List<Product> similarProducts;
  final List<ReviewModel> reviews;
  final int currentSizeIndex;
  final int currentImageIndex;
  final int currentColorIndex;
  final int quantity;
  final bool isLoadingReviews;
  final bool hasMoreReviews;
  final double averageRating;
  final int reviewCount;
  
  ProductDetailLoaded({
    required this.product,
    required this.similarProducts,
    required this.reviews,
    required this.currentSizeIndex,
    required this.currentImageIndex,
    required this.currentColorIndex,
    required this.quantity,
    required this.isLoadingReviews,
    required this.hasMoreReviews,
    required this.averageRating,
    required this.reviewCount,
  });
  
  ProductDetailLoaded copyWith({
    ProductModel? product,
    List<Product>? similarProducts,
    List<ReviewModel>? reviews,
    int? currentSizeIndex,
    int? currentImageIndex,
    int? currentColorIndex,
    int? quantity,
    bool? isLoadingReviews,
    bool? hasMoreReviews,
    double? averageRating,
    int? reviewCount,
  }) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      similarProducts: similarProducts ?? this.similarProducts,
      reviews: reviews ?? this.reviews,
      currentSizeIndex: currentSizeIndex ?? this.currentSizeIndex,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      currentColorIndex: currentColorIndex ?? this.currentColorIndex,
      quantity: quantity ?? this.quantity,
      isLoadingReviews: isLoadingReviews ?? this.isLoadingReviews,
      hasMoreReviews: hasMoreReviews ?? this.hasMoreReviews,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}

class ProductDetailError extends ProductDetailState {
  final String message;
  
  ProductDetailError(this.message);
}

class AddToCartLoading extends ProductDetailState {}

class AddToCartSuccess extends ProductDetailState {}

class AddToCartError extends ProductDetailState {
  final String message;
  
  AddToCartError(this.message);
}

class ReviewsLoading extends ProductDetailState {}

class ReviewsLoaded extends ProductDetailState {
  final List<ReviewModel> reviews;
  final bool hasMore;
  
  ReviewsLoaded({required this.reviews, required this.hasMore});
}

class ReviewsError extends ProductDetailState {
  final String message;
  
  ReviewsError(this.message);
}