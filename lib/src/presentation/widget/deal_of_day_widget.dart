import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/comman/routes.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/domain/entities/deal.dart';
import 'package:shoppywell/src/presentation/widget/product_card_widget.dart';

class DealOfDayWidget extends StatefulWidget {
  final Deal deal;
  final List<Product> products;

  const DealOfDayWidget({
    Key? key,
    required this.deal,
    required this.products,
  }) : super(key: key);

  @override
  _DealOfDayWidgetState createState() => _DealOfDayWidgetState();
}

class _DealOfDayWidgetState extends State<DealOfDayWidget> {
  // TODO: Implement timer logic
  final String _timeRemaining = 'Loading...';

  @override
  Widget build(BuildContext context) {
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
                Text(
                  widget.deal.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(onPressed: () {},
                 child: const Text('View all →')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.timer, size: 16, color: Colors.redAccent),
                const SizedBox(width: 4),
                Text(
                  '$_timeRemaining remaining', // Display timer
                  style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 240, // Adjust height as needed for product cards
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final product = widget.products[index];
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