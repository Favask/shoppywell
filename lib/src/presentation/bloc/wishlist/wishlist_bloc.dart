import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppywell/src/domain/usecase/wishlist.dart';
import 'package:shoppywell/src/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:shoppywell/src/presentation/bloc/wishlist/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistUsecase _wishlistUsecase = WishlistUsecase();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  WishlistBloc() : super(WishlistInitial()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<ClearWishlist>(_onClearWishlist);
  }

  Future<void> _onLoadWishlist(
    LoadWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(WishlistError('Please login to view wishlist'));
        return;
      }

      final products = await _wishlistUsecase.getWishlistProducts(user.uid);
      if (products.isEmpty) {
        emit(WishlistEmpty());
      } else {
        emit(WishlistLoaded(products));
      }
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(WishlistError('Please login to add to wishlist'));
        return;
      }

      await _wishlistUsecase.addToWishlist(user.uid, event.productId);
      
      // Reload wishlist after adding
      final products = await _wishlistUsecase.getWishlistProducts(user.uid);
      if (products.isEmpty) {
        emit(WishlistEmpty());
      } else {
        emit(WishlistLoaded(products));
      }
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(WishlistError('Please login to remove from wishlist'));
        return;
      }

      await _wishlistUsecase.removeFromWishlist(user.uid, event.productId);
      
      // Reload wishlist after removing
      final products = await _wishlistUsecase.getWishlistProducts(user.uid);
      if (products.isEmpty) {
        emit(WishlistEmpty());
      } else {
        emit(WishlistLoaded(products));
      }
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onClearWishlist(
    ClearWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(WishlistError('Please login to clear wishlist'));
        return;
      }

      await _wishlistUsecase.clearWishlist(user.uid);
      emit(WishlistEmpty());
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
} 