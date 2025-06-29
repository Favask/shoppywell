
// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final double rating;
//   final int reviews;
//   final String image;
//   final int reviewCount;


//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.rating,
//     required this.reviews,
//     required this.image,
//     required this.reviewCount,

//   });

//   factory Product.fromMap(Map<String, dynamic> map, String documentId) {
//     return Product(
//       id: documentId,
//       name: map['name'] ?? '',
//       description: map['description'] ?? '',
//       price: (map['price'] ?? 0).toDouble(),
//       rating: (map['rating'] ?? 0).toDouble(),
//       reviews: map['reviews'] ?? 0,
//       image: map['image'] ?? 'assets/placeholder.jpg',
//       reviewCount: map['reviewcount'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'description': description,
//       'price': price,
//       'rating': rating,
//       'reviews': reviews,
//       'image': image,
//       'reviewcount' : reviewCount
//     };
//   }
// }

