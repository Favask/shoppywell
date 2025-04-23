abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final String productId;
  
  LoadProductDetail(this.productId);
}

class AddToCart extends ProductDetailEvent {
  final int productId;
  
  AddToCart(this.productId);
}

class ChangeSizeSelection extends ProductDetailEvent {
  final int sizeIndex;
  
  ChangeSizeSelection(this.sizeIndex);
}

class ChangeImageIndex extends ProductDetailEvent {
  final int imageIndex;
  
  ChangeImageIndex(this.imageIndex);
}
