import 'package:equatable/equatable.dart';
import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.productId,
    required super.userId,
    required super.userName,
    super.userPhoto,
    required super.title,
    required super.comment,
    required super.rating,
    required super.images,
    required super.isHelpful,
    required super.isVerifiedPurchase,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ReviewModel(
      id: documentId,
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhoto: json['userPhoto'] as String?,
      title: json['title'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(),
      images: List<String>.from(json['images'] as List? ?? []),
      isHelpful: json['isHelpful'] as int? ?? 0,
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? false,
      createdAt: (json['createdAt'] as dynamic).toDate(),
      updatedAt: (json['updatedAt'] as dynamic).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'title': title,
      'comment': comment,
      'rating': rating,
      'images': images,
      'isHelpful': isHelpful,
      'isVerifiedPurchase': isVerifiedPurchase,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ReviewModel copyWith({
    String? id,
    String? productId,
    String? userId,
    String? userName,
    String? userPhoto,
    String? title,
    String? comment,
    double? rating,
    List<String>? images,
    int? isHelpful,
    bool? isVerifiedPurchase,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhoto: userPhoto ?? this.userPhoto,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      isHelpful: isHelpful ?? this.isHelpful,
      isVerifiedPurchase: isVerifiedPurchase ?? this.isVerifiedPurchase,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 