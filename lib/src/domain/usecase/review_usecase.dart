import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/review_model.dart';
import 'package:shoppywell/src/domain/repositories/review_repository.dart';

class ReviewUsecase {
  final ReviewRepository repository;

  ReviewUsecase(this.repository);

  Future<List<ReviewModel>> getProductReviews(String productId) async {
    return await repository.getProductReviews(productId);
  }

  Future<List<ReviewModel>> getProductReviewsPaginated(
    String productId,
    int limit,
    DocumentSnapshot? lastDocument,
  ) async {
    return await repository.getProductReviewsPaginated(
      productId,
      limit,
      lastDocument,
    );
  }

  Future<double> getAverageRating(String productId) async {
    return await repository.getAverageRating(productId);
  }

  Future<int> getReviewCount(String productId) async {
    return await repository.getReviewCount(productId);
  }
} 