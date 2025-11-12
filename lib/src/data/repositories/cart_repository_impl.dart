import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? paymentIntent;


  @override
  Future<String> getUserId(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (!userDoc.exists) {
      throw Exception('User not found');
    }
    final userData = userDoc.data() as Map<String, dynamic>;
    return userData['uid'];//*/
  }

  @override
  Future<List<Product>> getCartProducts() async {
    try {

      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not found');
      }


      // Get user's cart product IDs
      final  userDoc = await _firestore.collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();
      if (userDoc.docs.isEmpty) {
        throw Exception('User not found');
      }

      final  Map<String, dynamic> userData = userDoc.docs.first.data() ?? {};
      final cartIds = List<int>.from(userData['cart'] ?? []);

      if (cartIds.isEmpty) {
        return [];
      }

      // Fetch products using the cart IDs
      final products = <Product>[];
      for (final productId in cartIds) {
        try {
          final productDoc = await _firestore.collection('products').where('id', isEqualTo: productId).get();
          if (productDoc.docs.isNotEmpty) {
            final productData = productDoc.docs.first.data() ;
            print("-----productData-----$productData");
            final Product product = Product.fromMap(productData,productDoc.docs.first.id);
            products.add(product);
          }
        } catch (e) {
          // Skip products that can't be fetched
          print('Error fetching product $productId: $e');
        }
      }

      return products;
    } catch (e) {
      print("-----catch-----$e");
      throw Exception('Failed to fetch cart products: $e');
    }
  }

  @override
  Future<void> addToCart(String userId, int productId, int quantity, {String? size, String? color}) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'cart': FieldValue.arrayUnion([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(String userId, int productId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'cart': FieldValue.arrayRemove([productId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }


  @override
  Future<void> stripeMakePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'INR');
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              billingDetails: const BillingDetails(
                  name: 'YOUR NAME',
                  email: 'YOUREMAIL@gmail.com',
                  phone: 'YOUR NUMBER',
                  address: Address(
                      city: 'YOUR CITY',
                      country: 'YOUR COUNTRY',
                      line1: 'YOUR ADDRESS 1',
                      line2: 'YOUR ADDRESS 2',
                      postalCode: 'YOUR PINCODE',
                      state: 'YOUR STATE')),
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(msg: 'Payment succesfully completed');
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error: $e');
      }
    }
  }

//create Payment

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
 String calculateAmount(String amount)  {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
} 