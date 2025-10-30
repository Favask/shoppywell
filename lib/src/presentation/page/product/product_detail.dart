// UI: product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailPage extends StatefulWidget {
  final String? productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _imagePageController = PageController();
  final ScrollController _scrollController = ScrollController();
  bool _isWishlisted = false;

  @override
  void initState() {
    super.initState();
    print("---------widget.productId----${widget.productId}");
    if (widget.productId != null) {
      BlocProvider.of<ProductDetailBloc>(context)
          .add(LoadProductDetail(widget.productId!));
    }
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: _buildBody(state, theme),
        );
      },
    );
  }

  Widget _buildBody(ProductDetailState state, ThemeData theme) {
    if (state is ProductDetailLoading) {
      return _buildLoadingState();
    } else if (state is ProductDetailError) {
      return _buildErrorState(state.message);
    } else if (state is ProductDetailLoaded) {
      return _buildProductDetailContent(state, theme);
    }
    return _buildInitialState();
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading product details...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $message', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (widget.productId != null) {
                BlocProvider.of<ProductDetailBloc>(context)
                    .add(LoadProductDetail(widget.productId!));
              }
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text('No product data'),
    );
  }

  Widget _buildProductDetailContent(ProductDetailLoaded state, ThemeData theme) {
    final product = state.product;
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: 0,
          floating: false,
          pinned: true,
          backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.95),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: theme.iconTheme.color),
              onPressed: () => _shareProduct(product.id.toString()),
            ),
            IconButton(
              icon: Icon(
                _isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: _isWishlisted ? Colors.red : theme.iconTheme.color,
              ),
              onPressed: () => _toggleWishlist(product.id.toString()),
            ),
          ],
        ),
        SliverToBoxAdapter(child: _buildImageGallery(state, theme)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductInfo(state, theme),
                const SizedBox(height: 24),
                _buildColorSelection(state, theme),
                const SizedBox(height: 24),
                _buildSizeSelection(state, theme),
                const SizedBox(height: 24),
                _buildQuantitySelector(state, theme),
                const SizedBox(height: 24),
                _buildAddToCartButton(state, theme),
                const SizedBox(height: 24),
                _buildProductDetails(state, theme),
                const SizedBox(height: 24),
                _buildReviewsSection(state, theme),
                const SizedBox(height: 24),
                _buildRelatedProducts(state, theme),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery(ProductDetailLoaded state, ThemeData theme) {
    final product = state.product;
    return Container(
      height: 400,
      child: Stack(
        children: [
          PageView.builder(
            controller: _imagePageController,
            onPageChanged: (index) {
              BlocProvider.of<ProductDetailBloc>(context)
                  .add(ChangeImageIndex(index));
            },
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showFullScreenImage(product.images[index]),
                child: CachedNetworkImage(
                  imageUrl: product.images[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: theme.dividerColor,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: theme.dividerColor,
                    child: const Icon(Icons.error),
                  ),
                ),
              );
            },
          ),
          if (product.images.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  product.images.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.currentImageIndex == index
                          ? theme.cardColor
                          : theme.cardColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductDetailLoaded state, ThemeData theme) {
    final product = state.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   product.subtitle,
        //   style: theme.textTheme.bodyMedium?.copyWith(
        //     fontSize: 16,
        //     color: theme.hintColor,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        const SizedBox(height: 8),
        Text(
          product.name ?? "",
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < (product.rating?.floor()??0)
                      ? Icons.star
                      : (index < (product.rating??0)
                          ? Icons.star_half
                          : Icons.star_border),
                  color: Colors.amber,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${product.rating} (${state.reviewCount} reviews)',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: theme.hintColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if ((product.discountPercentage ?? 0 )> 0) ...[
              Text(
                '₹${product.originalPrice?.toStringAsFixed(0)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  color: theme.hintColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              '₹${product.salePrice?.toStringAsFixed(0)}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            if ((product.discountPercentage ?? 0 ) > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${product.discountPercentage}% OFF',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildColorSelection(ProductDetailLoaded state, ThemeData theme) {
    return Container(
      height: 50,
      color: theme.cardColor,
      child: Center(child: Text('Color selection placeholder', style: theme.textTheme.bodyMedium)),
    );
  }

  Widget _buildSizeSelection(ProductDetailLoaded state, ThemeData theme) {
    return Container(
      height: 50,
      color: theme.cardColor,
      child: Center(child: Text('Size selection placeholder', style: theme.textTheme.bodyMedium)),
    );
  }

  Widget _buildQuantitySelector(ProductDetailLoaded state, ThemeData theme) {
    return Container(
      height: 50,
      color: theme.cardColor,
      child: Center(child: Text('Quantity selector placeholder', style: theme.textTheme.bodyMedium)),
    );
  }

  Widget _buildAddToCartButton(ProductDetailLoaded state, ThemeData theme) {
    final product = state.product;
    final selectedSize = product.sizes.isNotEmpty 
        ? product.sizes[state.currentSizeIndex].toString() 
        : '';
    final selectedColor = 'Default'; // Replace with actual color selection if available
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          BlocProvider.of<ProductDetailBloc>(context).add(AddToCart(
            productId: product.id.toString(),
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            quantity: state.quantity,
          ));
          // Listen for success/error in BlocListener at a higher level if needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Added to cart!'),
              backgroundColor: theme.colorScheme.primary,
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        label: const Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(ProductDetailLoaded state, ThemeData theme) {
    return Container(
      color: theme.cardColor,
      child: Center(child: Text('Product details placeholder', style: theme.textTheme.bodyMedium)),
    );
  }

  Widget _buildReviewsSection(ProductDetailLoaded state, ThemeData theme) {
    return Container(
      color: theme.cardColor,
      child: Center(child: Text('Reviews section placeholder', style: theme.textTheme.bodyMedium)),
    );
  }

  Widget _buildRelatedProducts(ProductDetailLoaded state, ThemeData theme) {
    return Container(
      height: 100,
      color: theme.cardColor,
      child: Center(child: Text('Related products placeholder', style: theme.textTheme.bodyMedium)),
    );
  }

  void _showFullScreenImage(String imageUrl) {
    // Placeholder for full screen image viewer
  }

  void _shareProduct(String productId) {
    // Placeholder for share functionality
  }

  void _toggleWishlist(String productId) {
    setState(() {
      _isWishlisted = !_isWishlisted;
    });
    // Placeholder for wishlist logic
  }
}