import 'package:shoppywell/src/data/model/product_detail.dart';
import 'package:shoppywell/src/data/model/product_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductModel product;
  final List<Product> similarProducts;
  final int currentSizeIndex;
  final int currentImageIndex;
  
  ProductDetailLoaded({
    required this.product,
    required this.similarProducts,
    required this.currentSizeIndex,
    required this.currentImageIndex,
  });
  
  ProductDetailLoaded copyWith({
    ProductModel? product,
    List<Product>? similarProducts,
    int? currentSizeIndex,
    int? currentImageIndex,
  }) {
    return ProductDetailLoaded(
      product: product ?? this.product,
      similarProducts: similarProducts ?? this.similarProducts,
      currentSizeIndex: currentSizeIndex ?? this.currentSizeIndex,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
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