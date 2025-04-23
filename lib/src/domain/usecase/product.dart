import 'package:shoppywell/src/data/model/product_model.dart';
import 'package:shoppywell/src/data/repository/product_repo.dart';
import 'package:shoppywell/src/domain/repositories/product.dart';

class ProductUsecase {
  final ProductRepository _repository = ProductRepositoryImpl();

  Future<List<Product>> getProducts(Function(List<Product> products) onRequestSuccess,
      Function(Exception) onRequestFailure) async {
   return _repository.getProducts(
        onRequestSuccess: onRequestSuccess, onRequestFailure: onRequestFailure);
  }
}
