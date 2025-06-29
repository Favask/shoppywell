import 'package:equatable/equatable.dart';

class Deal extends Equatable {
  final String id;
  final String title;
  final String type;
  final List<String> productIds;
  final int discountPercentage;
  final DateTime startTime;
  final DateTime endTime;
  final bool isActive;
  final String badgeText;

  const Deal({
    required this.id,
    required this.title,
    required this.type,
    required this.productIds,
    required this.discountPercentage,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.badgeText,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        productIds,
        discountPercentage,
        startTime,
        endTime,
        isActive,
        badgeText,
      ];
} 