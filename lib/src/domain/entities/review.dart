import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String? userPhoto;
  final String title;
  final String comment;
  final double rating;
  final List<String> images;
  final int isHelpful;
  final bool isVerifiedPurchase;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    this.userPhoto,
    required this.title,
    required this.comment,
    required this.rating,
    required this.images,
    required this.isHelpful,
    required this.isVerifiedPurchase,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        userId,
        userName,
        userPhoto,
        title,
        comment,
        rating,
        images,
        isHelpful,
        isVerifiedPurchase,
        createdAt,
        updatedAt,
      ];
} 