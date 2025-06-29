import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('product');

  final _firestore = FirebaseFirestore.instance;
  // Get stream of products
  @override
  Future<List<Product>> getProducts(
      {required Function(List<Product> products) onRequestSuccess,
      required Function(Exception exception) onRequestFailure}) async {
    try {
      final snapshot = await _firestore.collection('product').get();
      print("-----snapshot-----${snapshot}");
      print("-----snapshot-----${snapshot.docs}");
      final products = snapshot.docs
          .map((doc) => Product.fromMap(doc.data(), doc.id ))
          .toList();
      print("-----products-----${products.length}");
      return products;
      //  onRequestSuccess(products);
    } catch (e) {
      print("-----catch-----$e");

      return [];
    }
    // // Get a single product
    // Future<Product?> getProduct(String id) async {

    //   try {
    //     DocumentSnapshot doc = await _productsCollection.doc(id).get();
    //     if (doc.exists) {
    //       return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    //     }
    //     return null;
    //   } catch (e) {
    //     throw Exception('Failed to get product: $e');
    //   }
    // }
  }
}
