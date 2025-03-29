import 'package:shoppywell/src/comman/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class TrendingProducts extends StatelessWidget {
  const TrendingProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            _buildItemsHeader(),
            Expanded(
              child: _buildProductGrid(),
            ),
          ],
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

  Widget _buildProductGrid() {
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Black Winter',
        'description': 'Autumn And Winter Casual Men Branded jacket...',
        'price': 999,
        'rating': 4.4,
        'reviews': 4285,
        'image': 'assets/black_winter.jpg',
      },
      {
        'name': 'Mens Starry',
        'description': 'Mens Starry Sky Printed Shirt 100% Cotton Fabric',
        'price': 399,
        'rating': 4.2,
        'reviews': 132354,
        'image': 'assets/starry_shirt.jpg',
      },
      {
        'name': 'Black Dress',
        'description': 'Solid Black Dress for Women, Sexy Chain Shorts Ladi...',
        'price': 2000,
        'rating': 4.5,
        'reviews': 232446,
        'image': 'assets/black_dress.jpg',
      },
      {
        'name': 'Pink Embroide...',
        'description': 'EARTHEN Rose Pink Embroidered Tiered Maxi...',
        'price': 1900,
        'rating': 4.3,
        'reviews': 45678,
        'image': 'assets/pink_dress.jpg',
      },
      {
        'name': 'Flare Dress',
        'description': 'Anthesis Black & Rust Orange Floral Print Tiered Midi F...',
        'price': 1990,
        'rating': 4.1,
        'reviews': 435566,
        'image': 'assets/flare_dress.jpg',
      },
      {
        'name': 'denim dress',
        'description': 'Blue cotton denim dress Look 2 Printed cotton dr...',
        'price': 999,
        'rating': 4.3,
        'reviews': 27344,
        'image': 'assets/denim_dress.jpg',
      },
      {
        'name': 'Jordan Stay',
        'description': 'The classic Air Jordan 12 to create a shoe that\'s fres...',
        'price': 4999,
        'rating': 3.8,
        'reviews': 1023436,
        'image': 'assets/jordan_shoes.jpg',
      },
      {
        'name': 'Realme 7',
        'description': '6 GB RAM | 64 GB ROM | Expandable Upto 256...',
        'price': 3499,
        'rating': 4.4,
        'reviews': 2345567,
        'image': 'assets/realme7.jpg',
      },
      {
        'name': 'Sony PS4',
        'description': 'Sony PS4 Console, 1TB Slim with 3 Games: Gran Ture...',
        'price': 1999,
        'rating': 4.1,
        'reviews': 6345566,
        'image': 'assets/ps4.jpg',
      },
      {
        'name': 'Black Jacket 12...',
        'description': 'This warm and comfortable jacket is great for learn...',
        'price': 2999,
        'rating': 4.2,
        'reviews': 523456,
        'image': 'assets/black_jacket.jpg',
      },
      {
        'name': 'D7200 Digital C...',
        'description': 'D7200 Digital Camera (Nikon) in New Area...',
        'price': 26499,
        'rating': 4.3,
        'reviews': 87432,
        'image': 'assets/camera.jpg',
      },
      {
        'name': 'men\'s & boys s...',
        'description': 'George Walker Derby Brown Formal Shoes',
        'price': 999,
        'rating': 4.4,
        'reviews': 1043267,
        'image': 'assets/formal_shoes.jpg',
      },
    ];

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
            context.pushNamed(
              AppRoutes.PROD_DTL_ROUTE_NAME,
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
                        image: AssetImage(product['image']),
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
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Description
                        Text(
                          product['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Price
                        Text(
                          '₹${product['price']}',
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
                                  i < (product['rating']).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${product['reviews']}',
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