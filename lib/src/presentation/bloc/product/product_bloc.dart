import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/model/product_model.dart';
import 'package:shoppywell/src/domain/usecase/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }

  // Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
  //   emit(ProductLoading());
  //   try {
  //     final snapshot = await _firestore.collection('product').get();
  //     print("-----snapshot-----${snapshot}");
  //           print("-----snapshot-----${snapshot.docs}");
  //     final products = snapshot.docs
  //         .map((doc) => Product.fromMap(doc.data(), doc.id))
  //         .toList();
  //     emit(ProductLoaded(products));
  //   } catch (e) {
  //     emit(ProductError(e.toString()));
  //   }
  // }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    ProductUsecase useCase = ProductUsecase();
    List<Product> response = await useCase.getProducts(
      (result) {},
      (exception) {},
    );
    emit(ProductLoaded(response));
  }
}
