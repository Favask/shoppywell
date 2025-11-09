import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/common/routes.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String currentPrice;
  final String originalPrice;
  final String discount;
  final double rating;
  final int reviews;
  final String? productId;

  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.currentPrice,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
    this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (productId != null) {
          context.pushNamed(
            AppRoutes.PROD_DTL_ROUTE_NAME,
            queryParameters: {'productId': productId},
          );
        }
      },
      child: Container(
        width: 160, // Adjust width as needed
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
                child: Image.network(
                  imageUrl, // Use Image.network for web images or Image.asset for local
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        currentPrice,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent, // Example color for price
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        discount,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green, // Example color for discount
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 16),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '($reviews)',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}