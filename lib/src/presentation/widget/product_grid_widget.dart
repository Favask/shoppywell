import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/common/routes.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/presentation/widget/product_card_widget.dart';

class ProductGridWidget extends StatelessWidget {
  final String title;
  final List<Product> products;
  final VoidCallback onSeeAllTap;
  final ScrollPhysics physics;
  final bool shrinkWrap;

  const ProductGridWidget({
    Key? key,
    required this.title,
    required this.products,
    required this.onSeeAllTap,
    this.physics = const NeverScrollableScrollPhysics(),
    this.shrinkWrap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(onPressed: onSeeAllTap,
               child: const Text('View all →')),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns as per the image
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.7, // Adjust as needed
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCardWidget(
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
              );
            },
          ),
        ],
      ),
    );
  }
} 