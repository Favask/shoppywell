import 'package:shoppywell/src/data/model/product_detail.dart';
import 'package:shoppywell/src/data/model/product_model.dart';
import 'package:shoppywell/src/data/repository/product_detail_repo.dart';
import 'package:shoppywell/src/domain/repositories/product_detail.dart';

class ProductDetailUsecase {
  final ProductDetailRepository _repository = ProductDetailRepositoryImpl();

  Future<ProductModel> getProductById(String productId){
    return _repository.getProductById(productId);
  }

  Future<List<Product>> getSimilarProducts(String category, int currentProductId) async {
    return _repository.getSimilarProducts(category, currentProductId);
  }


  Future<void> addToCart(int productId, String userId){
    return _repository.addToCart(productId, userId);
  }
}
