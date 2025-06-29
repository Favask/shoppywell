
import 'package:shoppywell/src/data/models/product_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> products;
  
  WishlistLoaded(this.products);
}

class WishlistEmpty extends WishlistState {}

class WishlistError extends WishlistState {
  final String message;
  
  WishlistError(this.message);
} 