import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final String icon;
  final bool isActive;
  final int sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.displayName,
    required this.icon,
    required this.isActive,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, name, displayName, icon, isActive, sortOrder];
} 