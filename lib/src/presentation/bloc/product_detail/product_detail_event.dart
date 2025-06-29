abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final String productId;
  
  LoadProductDetail(this.productId);
}

class LoadProductReviews extends ProductDetailEvent {
  final String productId;
  
  LoadProductReviews(this.productId);
}

class LoadMoreReviews extends ProductDetailEvent {
  final String productId;
  
  LoadMoreReviews(this.productId);
}

class AddToCart extends ProductDetailEvent {
  final String productId;
  final String selectedSize;
  final String selectedColor;
  final int quantity;
  
  AddToCart({
    required this.productId,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
  });
}

class BuyNow extends ProductDetailEvent {
  final String productId;
  final String selectedSize;
  final String selectedColor;
  final int quantity;
  
  BuyNow({
    required this.productId,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
  });
}

class ChangeSizeSelection extends ProductDetailEvent {
  final int sizeIndex;
  
  ChangeSizeSelection(this.sizeIndex);
}

class ChangeColorSelection extends ProductDetailEvent {
  final int colorIndex;
  
  ChangeColorSelection(this.colorIndex);
}

class ChangeImageIndex extends ProductDetailEvent {
  final int imageIndex;
  
  ChangeImageIndex(this.imageIndex);
}

class ChangeQuantity extends ProductDetailEvent {
  final int quantity;
  
  ChangeQuantity(this.quantity);
}

class ToggleWishlist extends ProductDetailEvent {
  final String productId;
  
  ToggleWishlist(this.productId);
}

class ShareProduct extends ProductDetailEvent {
  final String productId;
  
  ShareProduct(this.productId);
}
