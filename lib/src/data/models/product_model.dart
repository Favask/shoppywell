
import 'package:equatable/equatable.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.brand,
    required super.categoryId,
    required super.originalPrice,
    required super.salePrice,
    required super.discountPercentage,
    required super.images,
    required super.thumbnailUrl,
    required super.colors,
    required super.sizes,
    required super.stockQuantity,
    required super.isInStock,
    required super.rating,
    required super.reviewCount,
    required super.tags,
    required super.isActive,
    required super.isFeatured,
    required super.isTrending,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    print("--ProductModel-json-${json}");
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      brand: json['brand'] as String,
      categoryId: json['categoryId'] as String,
      originalPrice: (json['originalPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      discountPercentage: json['discountPercentage'] as int,
      images: List<String>.from(json['images'] as List),
      thumbnailUrl: json['thumbnailUrl'] as String,
      colors: List<String>.from(json['colors'] as List),
      sizes: List<String>.from(json['sizes'] as List),
      stockQuantity: json['stockQuantity'] as int,
      isInStock: json['isInStock'] as bool,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      tags: List<String>.from(json['tags'] as List),
      isActive: json['isActive'] as bool,
      isFeatured: json['isFeatured'] as bool,
      isTrending: json['isTrending'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'categoryId': categoryId,
      'originalPrice': originalPrice,
      'salePrice': salePrice,
      'discountPercentage': discountPercentage,
      'images': images,
      'thumbnailUrl': thumbnailUrl,
      'colors': colors,
      'sizes': sizes,
      'stockQuantity': stockQuantity,
      'isInStock': isInStock,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'isActive': isActive,
      'isFeatured': isFeatured,
      'isTrending': isTrending,
    };
  }
} 



class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String categoryId;
  final double originalPrice;
  final double salePrice;
  final int discountPercentage;
  final List<String> images;
  final String thumbnailUrl;
  final List<String> colors;
  final List<String> sizes;
  final int stockQuantity;
  final bool isInStock;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final bool isActive;
  final bool isFeatured;
  final bool isTrending;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.categoryId,
    required this.originalPrice,
    required this.salePrice,
    required this.discountPercentage,
    required this.images,
    required this.thumbnailUrl,
    required this.colors,
    required this.sizes,
    required this.stockQuantity,
    required this.isInStock,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.isActive,
    required this.isFeatured,
    required this.isTrending,
  });

   factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      salePrice: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      images: map['image'] ?? 'assets/placeholder.jpg',
      reviewCount: map['reviewcount'] ?? 0,
      brand: map['brand'] ?? 0,
      categoryId: map[''] ?? 0,
      colors: map[''] ?? 0,
      discountPercentage: map[''] ?? 0,
      isActive: map[''] ?? 0,
      isFeatured: map[''] ?? 0,
      isInStock: map[''] ?? 0,
      isTrending: map[''] ?? 0,
      originalPrice: map[''] ?? 0,
      sizes: map[''] ?? 0,
      stockQuantity: map[''] ?? 0,
      thumbnailUrl: map[''] ?? 0,
      tags:map[''] ?? 0 

    );
  }

 
  @override

  List<Object?> get props => [
        id,
        name,
        description,
        brand,
        categoryId,
        originalPrice,
        salePrice,
        discountPercentage,
        images,
        thumbnailUrl,
        colors,
        sizes,
        stockQuantity,
        isInStock,
        rating,
        reviewCount,
        tags,
        isActive,
        isFeatured,
        isTrending,
      ];
} 