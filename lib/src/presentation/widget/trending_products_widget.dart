import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/comman/routes.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/presentation/widget/product_card_widget.dart';

class TrendingProductsWidget extends StatelessWidget {
  final List<Product> products;
  final VoidCallback onSeeAllTap;

  const TrendingProductsWidget({
    Key? key,
    required this.products,
    required this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trending Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(onPressed: onSeeAllTap,
                 child: const Text('View all →')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 240, // Adjust height as needed for product cards
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 8.0),
                  child: ProductCardWidget(
                    product: product,
                    onTap: () {
                      // Navigate to product detail page
                      context.pushNamed(
                        AppRoutes.PROD_DTL_ROUTE_NAME,
                        queryParameters: {'productId': product.id},
                      );
                    },
                    onWishlistTap: () {
                      // TODO: Implement wishlist logic
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 