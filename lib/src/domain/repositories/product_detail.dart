import 'package:shoppywell/src/data/model/product_detail.dart';
import 'package:shoppywell/src/data/model/product_model.dart';

abstract class ProductDetailRepository {
  Future<ProductModel> getProductById(String productId);
  Future<List<Product>> getSimilarProducts(
      String category, int currentProductId);

  Future<void> addToCart(int productId, String userId);
}
