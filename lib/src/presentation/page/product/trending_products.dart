import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppywell/src/comman/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppywell/src/data/models/product_model.dart';
import 'package:shoppywell/src/presentation/bloc/product/product_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/product/product_event.dart';
import 'package:shoppywell/src/presentation/bloc/product/product_state.dart';



class TrendingProducts extends StatefulWidget {
  const TrendingProducts({Key? key}) : super(key: key);

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {

  @override
  void initState() {
     BlocProvider.of<ProductBloc>(context).add(LoadProducts());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
            return Column(
              children: [
                _buildAppBar(),
                _buildSearchBar(),
                _buildItemsHeader(),
                Expanded(
                  child: _buildProductGrid(products: state.products),
                ),
              ],
            );
          }
          return Container();
                }
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'shopy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'well',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.sentiment_satisfied_alt,
                  color: Colors.red,
                  size: 16,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 16,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8.0),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any Product...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Icon(Icons.mic, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '52,082+ Items',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sort, size: 18),
                label: const Text('Sort'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, size: 18),
                label: const Text('Filter'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
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
                    print("-------------2------");

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
                        image: NetworkImage(product.images[0]),
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
                          product.name ??'',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Description
                        Text(
                          product.description??"",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Price
                        Text(
                          '₹${product.salePrice}',
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
                                  i < ((product.rating)?.floor()??0)
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

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}