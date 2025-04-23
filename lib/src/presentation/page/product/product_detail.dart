// UI: product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/comman/routes.dart';
import 'package:shoppywell/src/data/model/product_model.dart';
import 'package:shoppywell/src/data/repository/product_detail_repo.dart';
import 'package:shoppywell/src/domain/repositories/product.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_state.dart';

class ProductDetailPage extends StatefulWidget {
  final String? productId;

  ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    print("---------widget.productId----${widget.productId}");
    if (widget.productId != null) {
      BlocProvider.of<ProductDetailBloc>(context)
          .add(LoadProductDetail(widget.productId!));
      // _productDetailBloc.add(LoadProductDetail(widget.productId!));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {
                // Navigate to cart
              },
            ),
          ],
        ),
        body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product added to cart!')),
              );
            } else if (state is AddToCartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to add product: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductDetailLoaded) {
              return _buildProductDetailContent(context, state);
            }
            return const Center(child: Text('No product data'));
          },
        ),
      ),
    );
  }

  Widget _buildProductDetailContent(
      BuildContext context, ProductDetailLoaded state) {
    final product = state.product;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Slider
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PageView.builder(
                  onPageChanged: (index) {
                    BlocProvider.of<ProductDetailBloc>(context)
                        .add(ChangeImageIndex(index));
                  },
                  itemCount: product.images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Image not available'));
                        },
                      ),
                    );
                  },
                ),
              ),
              if (product.images.length > 1)
                Positioned(
                  right: 10,
                  top: 100,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        final nextIndex =
                            state.currentImageIndex < product.images.length - 1
                                ? state.currentImageIndex + 1
                                : 0;
                        BlocProvider.of<ProductDetailBloc>(context)
                            .add(ChangeImageIndex(nextIndex));
                      },
                    ),
                  ),
                ),
            ],
          ),

          // Image Indicator
          if (product.images.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  product.images.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.currentImageIndex == index
                          ? Colors.red
                          : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),

          // Rest of the content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Size Text
                Text(
                  'Size: ${product.sizes[state.currentSizeIndex]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),

                // Size Selection
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      product.sizes.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildSizeButton(
                          product.sizes[index],
                          index,
                          state.currentSizeIndex,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Product Title
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  product.subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),

                // Ratings
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < product.rating.floor()
                            ? Icons.star
                            : (index < product.rating
                                ? Icons.star_half
                                : Icons.star_border),
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      product.reviewCount.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Price
                Row(
                  children: [
                    Text(
                      '₹${product.originalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '₹${product.discountedPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${product.discountPercentage}% Off',
                        style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Product Details
                const Text(
                  'Product Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Show full description
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'More',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red[400],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Store, VIP, Return Policy
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoButton(
                        Icons.location_on_outlined, 'Nearest Store'),
                    _buildInfoButton(Icons.verified_user_outlined, 'VIP'),
                    _buildInfoButton(Icons.autorenew, 'Return policy'),
                  ],
                ),
                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          BlocProvider.of<ProductDetailBloc>(context).add(AddToCart(product.id));
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Add to cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.pushNamed(
                                        AppRoutes.CART_ROUTE_NAME,
                                      );                        },
                        icon: const Icon(Icons.currency_rupee),
                        label: const Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Delivery Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Delivery in',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '1 within Hour',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // View Similar & Compare Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_outlined),
                        label: const Text('View Similar'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.compare_arrows),
                        label: const Text('Add to Compare'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Similar Products Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Similar To',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${state.similarProducts.length}+ Items',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Text('Sort'),
                          label: const Icon(Icons.sort, size: 18),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Text('Filter'),
                          label: const Icon(Icons.filter_list, size: 18),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Similar Products
                state.similarProducts.isEmpty
                    ? const Center(child: Text('No similar products found'))
                    : Container(
                      height: 300,
                      child: _buildProductGrid(products: state.similarProducts )),
                const SizedBox(
                    height: 80), // Add extra space for bottom nav bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeButton(int  size, int index, int currentSizeIndex) {
    bool isSelected = currentSizeIndex == index;

    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductDetailBloc>(context).add(ChangeSizeSelection(index));
      },
      child: Container(
        width: 65,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink[200] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.pink[200]! : Colors.pink[100]!,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            "$size",
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.pink[300],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(
    String title,
    String subtitle,
    String price,
    double rating,
    String ratingCount,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  'https://via.placeholder.com/180x180',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor()
                              ? Icons.star
                              : (index < rating
                                  ? Icons.star_half
                                  : Icons.star_border),
                          color: Colors.amber,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ratingCount,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildProductGrid({required List<Product> products}) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        
        final product = products[index];
        return GestureDetector(
          onTap: () {
                    print("-------------oT------");

            context.pushNamed(
              AppRoutes.PROD_DTL_ROUTE_NAME,
               queryParameters  : {'productId': product.id},
            );
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Product Details
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Name
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Description
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Price
                        Text(
                          '₹${product.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        // Product Rating
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                    (i) => Icon(
                                  i < (product.rating).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${product.reviewCount}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
