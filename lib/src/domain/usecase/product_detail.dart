import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/data/repository/product_detail_repo.dart';
import 'package:shoppywell/src/domain/repositories/product_detail.dart';

class ProductDetailUsecase {
  final ProductDetailRepository _repository = ProductDetailRepositoryImpl();

  Future<ProductModel> getProductById(String productId){
    return _repository.getProductById(productId);
  }

  Future<List<Product>> getSimilarProducts(String category, String? currentProductId) async {
    return _repository.getSimilarProducts(category, currentProductId);
  }


  Future<void> addToCart(int productId, String? userEmail){
    return _repository.addToCart(productId, userEmail);
  }
}
