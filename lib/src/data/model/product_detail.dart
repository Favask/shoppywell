// class ProductModel {                                         
//   final int? id;                                         
//   final String name;                                       
//   final String subtitle;                                   
//   final double originalPrice;                               
//   final double discountedPrice;                                    
//   final int discountPercentage;                                    
//   final double rating;                                     
//   final int reviewCount;                                   
//   final List<String> images;                                    
//   final String description;                                  
//   final List<String> sizes;                                    
//   final bool isInCart;                                     



//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.subtitle,
//     required this.originalPrice,
//     required this.discountedPrice,
//     required this.discountPercentage,
//     required this.rating,
//     required this.reviewCount,
//     required this.images,
//     required this.description,
//     required this.sizes,
//     this.isInCart = false,
//   });

//   factory ProductModel.fromMap(Map<String, dynamic> map, int? id) {
//     print("------map--${map}");
//     return ProductModel(
//       id: id,
//       name: map['title'] ?? '',
//       subtitle: map['subtitle'] ?? '',
//       originalPrice: (map['originalPrice'] ?? 0).toDouble(),
//       discountedPrice: (map['discountedPrice'] ?? 0).toDouble(),
//       discountPercentage: map['discountPercentage'] ?? 0,
//       rating: (map['rating'] ?? 0).toDouble(),
//       reviewCount: map['ratingCount'] ?? 0,
//       images: List<String>.from(map['images'] ?? []),
//       description: map['description'] ?? '',
//       sizes: List<String>.from(map['sizes'] ?? []),
//       isInCart: map['isInCart'] ?? false,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': name,
//       'subtitle': subtitle,
//       'originalPrice': originalPrice,
//       'discountedPrice': discountedPrice,
//       'discountPercentage': discountPercentage,
//       'rating': rating,
//       'ratingCount': reviewCount,
//       'images': images,
//       'description': description,
//       'sizes': sizes,
//       'isInCart': isInCart,
//     };
//   }

//   ProductModel copyWith({
//     int? id,
//     String? name,
//     String? subtitle,
//     double? originalPrice,
//     double? discountedPrice,
//     int? discountPercentage,
//     double? rating,
//     int? reviewCount,
//     List<String>? images,
//     String? description,
//     List<String>? sizes,
//     bool? isInCart,
//   }) {
//     return ProductModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       subtitle: subtitle ?? this.subtitle,
//       originalPrice: originalPrice ?? this.originalPrice,
//       discountedPrice: discountedPrice ?? this.discountedPrice,
//       discountPercentage: discountPercentage ?? this.discountPercentage,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//       images: images ?? this.images,
//       description: description ?? this.description,
//       sizes: sizes ?? this.sizes,
//       isInCart: isInCart ?? this.isInCart,
//     );
//   }
// }
