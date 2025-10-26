abstract class WishlistEvent {}

class LoadWishlist extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final String productId;
  
  AddToWishlist(this.productId);
}

class RemoveFromWishlist extends WishlistEvent {
  final String productId;
  
  RemoveFromWishlist(this.productId);
}

class ClearWishlist extends WishlistEvent {} 