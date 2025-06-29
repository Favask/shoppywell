import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppywell/src/data/models/review_model.dart';
import 'package:shoppywell/src/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ReviewModel>> getProductReviews(String productId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('reviews')
          .where('productId', isEqualTo: productId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch reviews: $e');
    }
  }

  @override
  Future<List<ReviewModel>> getProductReviewsPaginated(
    String productId,
    int limit,
    DocumentSnapshot? lastDocument,
  ) async {
    try {
      Query query = _firestore
          .collection('reviews')
          .where('productId', isEqualTo: productId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final QuerySnapshot snapshot = await query.get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch paginated reviews: $e');
    }
  }

  @override
  Future<double> getAverageRating(String productId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('reviews')
          .where('productId', isEqualTo: productId)
          .get();

      if (snapshot.docs.isEmpty) {
        return 0.0;
      }

      double totalRating = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        totalRating += (data['rating'] as num).toDouble();
      }

      return totalRating / snapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to calculate average rating: $e');
    }
  }

  @override
  Future<int> getReviewCount(String productId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('reviews')
          .where('productId', isEqualTo: productId)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get review count: $e');
    }
  }
} 