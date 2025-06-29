// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shoppywell/src/comman/routes.dart';
// import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_bloc.dart';
// import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_event.dart';
// import 'package:shoppywell/src/presentation/bloc/product_detail/product_detail_state.dart';
// import 'package:shoppywell/src/presentation/widget/product_card_widget.dart';
// import 'package:shoppywell/src/utilities/snackbar_utils.dart';
// import 'package:shoppywell/src/data/models/review_model.dart';
// import 'package:shoppywell/src/data/model/product_model.dart';
// import 'package:shoppywell/src/domain/entities/product.dart' as domain;

// class ComprehensiveProductDetailPage extends StatefulWidget {
//   final String? productId;

//   const ComprehensiveProductDetailPage({Key? key, required this.productId}) 
//       : super(key: key);

//   static const String routeName = 'comprehensive_product_detail';

//   @override
//   State<ComprehensiveProductDetailPage> createState() => _ComprehensiveProductDetailPageState();
// }

// class _ComprehensiveProductDetailPageState extends State<ComprehensiveProductDetailPage> {
//   final PageController _imagePageController = PageController();
//   final ScrollController _scrollController = ScrollController();
//   bool _isWishlisted = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.productId != null) {
//       BlocProvider.of<ProductDetailBloc>(context)
//           .add(LoadProductDetail(widget.productId!));
//     }
//   }

//   @override
//   void dispose() {
//     _imagePageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductDetailBloc, ProductDetailState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: _buildBody(state),
//         );
//       },
//     );
//   }

//   Widget _buildBody(ProductDetailState state) {
//     if (state is ProductDetailLoading) {
//       return _buildLoadingState();
//     } else if (state is ProductDetailError) {
//       return _buildErrorState(state.message);
//     } else if (state is ProductDetailLoaded) {
//       return _buildProductDetailContent(state);
//     }
//     return _buildInitialState();
//   }

//   Widget _buildLoadingState() {
//     return const Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text('Loading product details...'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState(String message) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, size: 64, color: Colors.red),
//             const SizedBox(height: 16),
//             Text('Error: $message', textAlign: TextAlign.center),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (widget.productId != null) {
//                   BlocProvider.of<ProductDetailBloc>(context)
//                       .add(LoadProductDetail(widget.productId!));
//                 }
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInitialState() {
//     return const Scaffold(
//       body: Center(
//         child: Text('No product data'),
//       ),
//     );
//   }

//   Widget _buildProductDetailContent(ProductDetailLoaded state) {
//     final product = state.product;
    
//     return CustomScrollView(
//       controller: _scrollController,
//       slivers: [
//         // Custom AppBar with transparent background
//         SliverAppBar(
//           expandedHeight: 0,
//           floating: false,
//           pinned: true,
//           backgroundColor: Colors.white.withOpacity(0.9),
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.share, color: Colors.black),
//               onPressed: () => _shareProduct(product.id.toString()),
//             ),
//             IconButton(
//               icon: Icon(
//                 _isWishlisted ? Icons.favorite : Icons.favorite_border,
//                 color: _isWishlisted ? Colors.red : Colors.black,
//               ),
//               onPressed: () => _toggleWishlist(product.id.toString()),
//             ),
//           ],
//         ),
        
//         // Product Image Gallery
//         SliverToBoxAdapter(
//           child: _buildImageGallery(state),
//         ),
        
//         // Product Information
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildProductInfo(state),
//                 const SizedBox(height: 24),
//                 _buildColorSelection(state),
//                 const SizedBox(height: 24),
//                 _buildSizeSelection(state),
//                 const SizedBox(height: 24),
//                 _buildQuantitySelector(state),
//                 const SizedBox(height: 24),
//                 _buildActionButtons(state),
//                 const SizedBox(height: 24),
//                 _buildProductDetails(state),
//                 const SizedBox(height: 24),
//                 _buildReviewsSection(state),
//                 const SizedBox(height: 24),
//                 _buildRelatedProducts(state),
//                 const SizedBox(height: 100), // Bottom padding
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildImageGallery(ProductDetailLoaded state) {
//     final product = state.product;
    
//     return Container(
//       height: 400,
//       child: Stack(
//         children: [
//           // Image PageView
//           PageView.builder(
//             controller: _imagePageController,
//             onPageChanged: (index) {
//               BlocProvider.of<ProductDetailBloc>(context)
//                   .add(ChangeImageIndex(index));
//             },
//             itemCount: product.images.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () => _showFullScreenImage(product.images[index]),
//                 child: CachedNetworkImage(
//                   imageUrl: product.images[index],
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => Container(
//                     color: Colors.grey[200],
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => Container(
//                     color: Colors.grey[200],
//                     child: const Icon(Icons.error),
//                   ),
//                 ),
//               );
//             },
//           ),
          
//           // Image indicators
//           if (product.images.length > 1)
//             Positioned(
//               bottom: 16,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   product.images.length,
//                   (index) => Container(
//                     width: 8,
//                     height: 8,
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: state.currentImageIndex == index
//                           ? Colors.white
//                           : Colors.white.withOpacity(0.5),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductInfo(ProductDetailLoaded state) {
//     final product = state.product;
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Brand
//         Text(
//           product.subtitle,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
        
//         // Product name
//         Text(
//           product.name,
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
        
//         // Rating and reviews
//         Row(
//           children: [
//             Row(
//               children: List.generate(
//                 5,
//                 (index) => Icon(
//                   index < product.rating.floor()
//                       ? Icons.star
//                       : (index < product.rating
//                           ? Icons.star_half
//                           : Icons.star_border),
//                   color: Colors.amber,
//                   size: 20,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               '${product.rating} (${state.reviewCount} reviews)',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
        
//         // Price
//         Row(
//           children: [
//             if (product.discountPercentage > 0) ...[
//               Text(
//                 '₹${product.originalPrice.toStringAsFixed(0)}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                   decoration: TextDecoration.lineThrough,
//                 ),
//               ),
//               const SizedBox(width: 8),
//             ],
//             Text(
//               '₹${product.discountedPrice.toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ),
//             if (product.discountPercentage > 0) ...[
//               const SizedBox(width: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.red[50],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   '${product.discountPercentage}% OFF',
//                   style: TextStyle(
//                     color: Colors.red[700],
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildColorSelection(ProductDetailLoaded state) {
//     // Mock colors since ProductModel doesn't have colors
//     final colors = ['Red', 'Blue', 'Green', 'Black', 'White'];
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Color',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 50,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: colors.length,
//             itemBuilder: (context, index) {
//               final isSelected = state.currentColorIndex == index;
//               return GestureDetector(
//                 onTap: () {
//                   BlocProvider.of<ProductDetailBloc>(context)
//                       .add(ChangeColorSelection(index));
//                 },
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   margin: const EdgeInsets.only(right: 12),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: _getColorFromString(colors[index]),
//                     border: Border.all(
//                       color: isSelected ? Colors.blue : Colors.grey[300]!,
//                       width: isSelected ? 3 : 1,
//                     ),
//                   ),
//                   child: isSelected
//                       ? const Icon(Icons.check, color: Colors.white, size: 20)
//                       : null,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSizeSelection(ProductDetailLoaded state) {
//     final product = state.product;
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Size',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextButton(
//               onPressed: () => _showSizeGuide(),
//               child: const Text('Size Guide'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 50,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: product.sizes.length,
//             itemBuilder: (context, index) {
//               final size = product.sizes[index];
//               final isSelected = state.currentSizeIndex == index;
//               final isOutOfStock = false; // Mock out of stock status
              
//               return GestureDetector(
//                 onTap: isOutOfStock ? null : () {
//                   BlocProvider.of<ProductDetailBloc>(context)
//                       .add(ChangeSizeSelection(index));
//                 },
//                 child: Container(
//                   width: 60,
//                   height: 50,
//                   margin: const EdgeInsets.only(right: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: isSelected 
//                         ? Colors.blue 
//                         : (isOutOfStock ? Colors.grey[200] : Colors.white),
//                     border: Border.all(
//                       color: isSelected 
//                           ? Colors.blue 
//                           : (isOutOfStock ? Colors.grey[300]! : Colors.grey[300]!),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       size.toString(),
//                       style: TextStyle(
//                         color: isSelected 
//                             ? Colors.white 
//                             : (isOutOfStock ? Colors.grey[500] : Colors.black),
//                         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildQuantitySelector(ProductDetailLoaded state) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Quantity',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             IconButton(
//               onPressed: state.quantity > 1 ? () {
//                 BlocProvider.of<ProductDetailBloc>(context)
//                     .add(ChangeQuantity(state.quantity - 1));
//               } : null,
//               icon: const Icon(Icons.remove),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey[300]!),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 state.quantity.toString(),
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             IconButton(
//               onPressed: state.quantity < 10 ? () {
//                 BlocProvider.of<ProductDetailBloc>(context)
//                     .add(ChangeQuantity(state.quantity + 1));
//               } : null,
//               icon: const Icon(Icons.add),
//             ),
//             const Spacer(),
//             Text(
//               'Only 10 left in stock',
//               style: TextStyle(
//                 color: Colors.orange[700],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButtons(ProductDetailLoaded state) {
//     final product = state.product;
//     final selectedSize = product.sizes.isNotEmpty 
//         ? product.sizes[state.currentSizeIndex].toString() 
//         : '';
//     final selectedColor = 'Red'; // Mock color selection
    
//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton(
//             onPressed: () {
//               _addToCart(product.id.toString(), selectedSize, selectedColor, state.quantity);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Add to Cart',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton(
//             onPressed: () {
//               _buyNow(product.id.toString(), selectedSize, selectedColor, state.quantity);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Buy Now',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProductDetails(ProductDetailLoaded state) {
//     final product = state.product;
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Product Details',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Text(
//           product.description,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.black87,
//             height: 1.5,
//           ),
//         ),
//         const SizedBox(height: 16),
        
//         // Features
//         const Text(
//           'Features',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         _buildFeatureItem('Premium quality material'),
//         _buildFeatureItem('Comfortable fit'),
//         _buildFeatureItem('Easy to maintain'),
//         _buildFeatureItem('Multiple color options'),
        
//         const SizedBox(height: 16),
        
//         // Materials
//         const Text(
//           'Materials',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           '100% Cotton',
//           style: TextStyle(fontSize: 14, color: Colors.black87),
//         ),
//       ],
//     );
//   }

//   Widget _buildFeatureItem(String feature) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         children: [
//           const Icon(Icons.check_circle, color: Colors.green, size: 16),
//           const SizedBox(width: 8),
//           Text(
//             feature,
//             style: const TextStyle(fontSize: 14, color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewsSection(ProductDetailLoaded state) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Reviews (${state.reviewCount})',
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             if (state.reviewCount > 0)
//               TextButton(
//                 onPressed: () => _viewAllReviews(),
//                 child: const Text('View All'),
//               ),
//           ],
//         ),
//         const SizedBox(height: 16),
        
//         if (state.reviews.isEmpty)
//           const Center(
//             child: Text(
//               'No reviews yet',
//               style: TextStyle(color: Colors.grey),
//             ),
//           )
//         else
//           Column(
//             children: [
//               ...state.reviews.take(3).map((review) => _buildReviewCard(review)),
//               if (state.hasMoreReviews)
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       BlocProvider.of<ProductDetailBloc>(context)
//                           .add(LoadMoreReviews(widget.productId!));
//                     },
//                     child: Text(
//                       state.isLoadingReviews ? 'Loading...' : 'Load More Reviews',
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//       ],
//     );
//   }

//   Widget _buildReviewCard(ReviewModel review) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage: review.userPhoto != null
//                     ? CachedNetworkImageProvider(review.userPhoto!)
//                     : null,
//                 child: review.userPhoto == null
//                     ? Text(review.userName[0].toUpperCase())
//                     : null,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       review.userName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Row(
//                           children: List.generate(
//                             5,
//                             (index) => Icon(
//                               index < review.rating.floor()
//                                   ? Icons.star
//                                   : Icons.star_border,
//                               color: Colors.amber,
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           _formatDate(review.createdAt),
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               if (review.isVerifiedPurchase)
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.green[50],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     'Verified',
//                     style: TextStyle(
//                       color: Colors.green[700],
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             review.title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             review.comment,
//             style: const TextStyle(
//               color: Colors.black87,
//               height: 1.4,
//             ),
//           ),
//           if (review.images.isNotEmpty) ...[
//             const SizedBox(height: 12),
//             SizedBox(
//               height: 80,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: review.images.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: 80,
//                     height: 80,
//                     margin: const EdgeInsets.only(right: 8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       image: DecorationImage(
//                         image: CachedNetworkImageProvider(review.images[index]),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => _markReviewHelpful(review.id),
//                 icon: const Icon(Icons.thumb_up_outlined, size: 16),
//               ),
//               Text(
//                 '${review.isHelpful} helpful',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRelatedProducts(ProductDetailLoaded state) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'You might also like',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 300,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: state.similarProducts.length,
//             itemBuilder: (context, index) {
//               final product = state.similarProducts[index];
//               return Container(
//                 width: 200,
//                 margin: const EdgeInsets.only(right: 16),
//                 child: _buildSimpleProductCard(product),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSimpleProductCard(Product product) {
//     return GestureDetector(
//       onTap: () => _navigateToProduct(product.id),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//               child: CachedNetworkImage(
//                 imageUrl: product.image,
//                 height: 120,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => Container(
//                   height: 120,
//                   color: Colors.grey[200],
//                 ),
//                 errorWidget: (context, url, error) => Container(
//                   height: 120,
//                   color: Colors.grey[300],
//                   child: const Icon(Icons.error),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Brand', // Mock brand since Product model doesn't have brand
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         '₹${product.price.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Colors.amber[700],
//                         size: 16,
//                       ),
//                       const SizedBox(width: 2),
//                       Text(
//                         product.rating.toStringAsFixed(1),
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '(${product.reviewCount})',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper methods
//   Color _getColorFromString(String colorName) {
//     switch (colorName.toLowerCase()) {
//       case 'red':
//         return Colors.red;
//       case 'blue':
//         return Colors.blue;
//       case 'green':
//         return Colors.green;
//       case 'black':
//         return Colors.black;
//       case 'white':
//         return Colors.white;
//       default:
//         return Colors.grey;
//     }
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);
    
//     if (difference.inDays > 0) {
//       return '${difference.inDays} days ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours} hours ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes} minutes ago';
//     } else {
//       return 'Just now';
//     }
//   }

//   void _showFullScreenImage(String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Scaffold(
//           backgroundColor: Colors.black,
//           body: Stack(
//             children: [
//               Center(
//                 child: InteractiveViewer(
//                   child: CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 50,
//                 left: 16,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSizeGuide() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Size Guide'),
//         content: const Text('Size guide information will be displayed here.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _addToCart(String productId, String size, String color, int quantity) {
//     BlocProvider.of<ProductDetailBloc>(context).add(
//       AddToCart(
//         productId: productId,
//         selectedSize: size,
//         selectedColor: color,
//         quantity: quantity,
//       ),
//     );
//   }

//   void _buyNow(String productId, String size, String color, int quantity) {
//     BlocProvider.of<ProductDetailBloc>(context).add(
//       BuyNow(
//         productId: productId,
//         selectedSize: size,
//         selectedColor: color,
//         quantity: quantity,
//       ),
//     );
//   }

//   void _toggleWishlist(String productId) {
//     setState(() {
//       _isWishlisted = !_isWishlisted;
//     });
//     BlocProvider.of<ProductDetailBloc>(context).add(ToggleWishlist(productId));
//   }

//   void _shareProduct(String productId) {
//     BlocProvider.of<ProductDetailBloc>(context).add(ShareProduct(productId));
//     // Show snackbar for now
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Share functionality coming soon!')),
//     );
//   }

//   void _viewAllReviews() {
//     // Navigate to full reviews page
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Full reviews page coming soon!')),
//     );
//   }

//   void _markReviewHelpful(String reviewId) {
//     // Mark review as helpful
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Review marked as helpful!')),
//     );
//   }

//   void _navigateToProduct(String productId) {
//     context.pushNamed(
//       AppRoutes.PROD_DTL_ROUTE_NAME,
//       queryParameters: {'productId': productId},
//     );
//   }
// } 