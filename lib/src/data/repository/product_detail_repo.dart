import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/product_detail.dart';

class ProductDetailRepositoryImpl  extends ProductDetailRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ProductModel> getProductById(String productId) async {
    // final DocumentSnapshot docHeader = await _firestore.collection('product').doc(productId).get();
    // final DocumentSnapshot docDetail = await _firestore.collection('productDetail').doc(productId).get();
    print("---productId---$productId");
        final DocumentSnapshot docDtl = await _firestore.collection('products').doc(productId).get();
print("--docDtl.data()--${docDtl.data()}");

    final Map<String, dynamic> doc={...docDtl.data() as Map<String, dynamic> };

    if (doc == {}) {
      throw Exception('Product not found');
    }
        print("------doc------$doc");
                print("------doc[name]------${doc["name"]}");
                
                        print("------doc------${doc["id"]}");
      int? val= doc["id"];
      print("--val--$val");
    return ProductModel.fromJson({...doc,'id' :val });
  }

  @override
  Future<List<Product>> getSimilarProducts(String category, String? currentProductId) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('product')
        // .where('category', isEqualTo: category)
        // .where(FieldPath.documentId, isNotEqualTo: currentProductId)
        .limit(2)
        .get();
    

    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id ))  //*/
        .toList();
  }

  @override
  Future<void> addToCart(int  productId, String? userEmail) async {
     // Get reference to the users collection
    final usersRef = FirebaseFirestore.instance.collection('users');
    

print("-----usersRef-$usersRef");

    // Query for documents where email matches
    final querySnapshot = await usersRef.where('email', isEqualTo: userEmail).get();
    
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first matching document (assuming emails are unique)
      final doc = querySnapshot.docs.first;
      
      // Update the array field using arrayUnion (won't add if already exists)
      await doc.reference.update({
        'cart': FieldValue.arrayUnion([productId])
      });
      
      print('ID added successfully');
    } else {
      print('No user found with email: $userEmail');
    }

    // // Update the isInCart field in the product document (optional)
    // await _firestore.collection('productDetail').doc("$productId").update({
    //   'isInCart': true
    // });
  }
}