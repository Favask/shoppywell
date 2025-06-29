import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/deal.dart';

class DealModel extends Deal {
  const DealModel({
    required super.id,
    required super.title,
    required super.type,
    required super.productIds,
    required super.discountPercentage,
    required super.startTime,
    required super.endTime,
    required super.isActive,
    required super.badgeText,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      productIds: List<String>.from(json['productIds'] as List),
      discountPercentage: json['discountPercentage'] as int,
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      isActive: json['isActive'] as bool,
      badgeText: json['badgeText'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'productIds': productIds,
      'discountPercentage': discountPercentage,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'isActive': isActive,
      'badgeText': badgeText,
    };
  }
} 