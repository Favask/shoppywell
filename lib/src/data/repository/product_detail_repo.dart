import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/model/product_detail.dart';
import 'package:shoppywell/src/data/model/product_model.dart';
import 'package:shoppywell/src/domain/repositories/product_detail.dart';

class ProductDetailRepositoryImpl  extends ProductDetailRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ProductModel> getProductById(String productId) async {
    final DocumentSnapshot docHeader = await _firestore.collection('product').doc(productId).get();
    final DocumentSnapshot docDetail = await _firestore.collection('productDetail').doc(productId).get();
    
    final Map<String, dynamic> doc={...docHeader.data() as Map<String, dynamic> ,...docDetail.data() as Map<String, dynamic>};

    print("------doc------${doc}");
    if (doc == {}) {
      throw Exception('Product not found');
    }
    
    return ProductModel.fromMap(doc , doc["id"]);
  }

  Future<List<Product>> getSimilarProducts(String category, int currentProductId) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('product')
        // .where('category', isEqualTo: category)
        // .where(FieldPath.documentId, isNotEqualTo: currentProductId)
        .limit(2)
        .get();
    

    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id ))
        .toList();
  }

  @override
  Future<void> addToCart(int  productId, String userId) async {
    // // Add product to user's cart collection
    // await _firestore.collection('productDetail').doc(userId).collection('cart').doc("$productId").set({
    //   'addedAt': FieldValue.serverTimestamp(),
    // });
    
    // Update the isInCart field in the product document (optional)
    await _firestore.collection('productDetail').doc("$productId").update({
      'isInCart': true
    });
  }
}