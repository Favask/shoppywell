
import 'package:shoppywell/src/data/models/product_model.dart';

abstract class ProductDetailRepository {
  Future<ProductModel> getProductById(String productId);
  Future<List<Product>> getSimilarProducts(
      String category, String? currentProductId);

  Future<void> addToCart(int productId, String? userId);
}
