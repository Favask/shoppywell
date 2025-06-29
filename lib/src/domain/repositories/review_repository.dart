import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/review_model.dart';

abstract class ReviewRepository {
  Future<List<ReviewModel>> getProductReviews(String productId);
  Future<List<ReviewModel>> getProductReviewsPaginated(
    String productId,
    int limit,
    DocumentSnapshot? lastDocument,
  );
  Future<double> getAverageRating(String productId);
  Future<int> getReviewCount(String productId);
} 