import 'package:shoppywell/src/data/model/product_model.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({
    required Function(List<Product> products) onRequestSuccess,
    required Function(Exception exception) onRequestFailure,
  });
}
