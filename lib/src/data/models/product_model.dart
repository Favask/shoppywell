import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends Product {
  ProductModel({
     super.id,
     super.name,
     super.description,
     super.brand,
     super.categoryId,
     super.originalPrice,
     super.salePrice,
     super.discountPercentage,
     super.images,
     super.thumbnailUrl,
     super.colors,
     super.sizes,
     super.stockQuantity,
     super.isInStock,
     super.rating,
     super.reviewCount,
     super.tags,
     super.isActive,
     super.isFeatured,
     super.isTrending,
     super.subCategory,
     super.metaDescription,
     super.features,
     super.createdAt,
     super.currency,
     super.slug,
     super.updatedAt,
     super.materials,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    print("--ProductModel-json-$json");
    return ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      categoryId: json['categoryId'] as String?,
      originalPrice: json['originalPrice'] != null ? (json['originalPrice'] as num).toDouble() : null,
      salePrice: json['salePrice'] != null ? (json['salePrice'] as num).toDouble() : null,
      discountPercentage: json['discountPercentage'] as int?,
      images: json['images'] != null ? List<String>.from(json['images'] as List) : [],
      thumbnailUrl: json['thumbnailUrl'] as String?,
      colors: json['colors'] != null ? List<String>.from(json['colors'] as List) : [],
      sizes: json['sizes'] != null ? List<String>.from(json['sizes'] as List) : [],
      stockQuantity: json['stockQuantity'] as int?,
      isInStock: json['isInStock'] as bool?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      reviewCount: json['reviewCount'] as int?,
      tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : [],
      isActive: json['isActive'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isTrending: json['isTrending'] as bool? ?? false,
      subCategory: json['subCategory'] as String?,
      metaDescription: json['metaDescription'] as String?,
      features: json['features'] != null ? List<String>.from(json['features'] as List) : [],
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
      currency: json['currency'] as String?,
      slug: json['slug'] as String?,
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() : null,
      materials: json['materials'] != null ? List<String>.from(json['materials'] as List) : [],
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
      'subCategory': subCategory,
      'metaDescription': metaDescription,
      'features': features,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'currency': currency,
      'slug': slug,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'materials': materials,
    };
  }
} 



class Product  {
  final String? documentId;
  final int? id;
  final String? name;
  final String? description;
  final String? brand;
  final String? categoryId;
  final double? originalPrice;
  final double? salePrice;
  final int? discountPercentage;
  List<String> images=[];
  final String? thumbnailUrl;
  List<String> colors=[];
  List<String> sizes=[];
  final int? stockQuantity;
  final bool? isInStock;
  final double? rating;
  final int? reviewCount;
  List<String> tags=[];
  final bool isActive;
  final bool isFeatured;
  final bool isTrending;
  final String? subCategory;
  final String? metaDescription;
  List<String> features=[];
  final DateTime? createdAt;
  final String? currency;
  final String? slug;
  final DateTime? updatedAt;
  List<String> materials=[];

  Product({
      this.documentId,
      this.id,
      this.name,
      this.description,
      this.brand,
      this.categoryId,
      this.originalPrice,
      this.salePrice,
      this.discountPercentage,
      this.images=const [],
      this.thumbnailUrl,
      this.colors=const [],
      this.sizes=const [],
      this.stockQuantity,
      this.isInStock,
      this.rating,
      this.reviewCount,
      this.tags=const [],
      this.isActive = false,
      this.isFeatured = false,
      this.isTrending = false,
      this.subCategory,
      this.metaDescription,
      this.features=const [],
      this.createdAt,
      this.currency,
      this.slug,
      this.updatedAt,
      this.materials=const [],
  });

   factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      documentId: documentId,
      id: map['id'] as int?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      salePrice: map['salePrice'] != null ? (map['salePrice'] as num).toDouble() : null,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      images: map['images'] != null ? List<String>.from(map['images'] as List) : [],
      reviewCount: map['reviewCount'] as int?,
      brand: map['brand'] as String?,
      categoryId: map['categoryId'] as String?,
      colors: map['colors'] != null ? List<String>.from(map['colors'] as List) : [],
      discountPercentage: map['discountPercentage'] as int?,
      isActive: map['isActive'] as bool? ?? false,
      isFeatured: map['isFeatured'] as bool? ?? false,
      isInStock: map['isInStock'] as bool?,
      isTrending: map['isTrending'] as bool? ?? false,
      originalPrice: map['originalPrice'] != null ? (map['originalPrice'] as num).toDouble() : null,
      sizes: map['sizes'] != null ? List<String>.from(map['sizes'] as List) : [],
      stockQuantity: map['stockQuantity'] as int?,
      thumbnailUrl: map['thumbnailUrl'] as String?,
      tags: map['tags'] != null ? List<String>.from(map['tags'] as List) : [],
      subCategory: map['subCategory'] as String?,
      metaDescription: map['metaDescription'] as String?,
      features: map['features'] != null ? List<String>.from(map['features'] as List) : [],
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate() : null,
      currency: map['currency'] as String?,
      slug: map['slug'] as String?,
      updatedAt: map['updatedAt'] != null ? (map['updatedAt'] as Timestamp).toDate() : null,
      materials: map['materials'] != null ? List<String>.from(map['materials'] as List) : [],
    );
  }

} 