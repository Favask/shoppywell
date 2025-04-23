import 'package:shoppywell/src/comman/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';




class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          children: [
            const Text(
              'shopy',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const Text(
              'well',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  ')',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.pushNamed(AppRoutes.PROFILE_ROUTE_NAME);
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.red,
              child: ClipOval(
                child: Image.network(
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search any Product...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 16),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Featured',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Text('Sort'),
                        label: const Icon(Icons.sort, size: 18),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Text('Filter'),
                        label: const Icon(Icons.filter_list, size: 18),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category icons
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryItem('Beauty', 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                    _buildCategoryItem('Fashion', 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                    _buildCategoryItem('Kids', 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                    _buildCategoryItem('Mens', 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                    _buildCategoryItem('Womens', 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                  ],
                ),
              ),

              // Banner
              Container(
                height: 160,
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '50-40% OFF',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('Most in-demand!\nAll colors'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: const Text('Shop Now →'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Deal of the day
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white),
                        const SizedBox(width: 8),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deal of the Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '22h 55m 20s remaining',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      ),
                      child: const Row(
                        children: [
                          Text('View all', style: TextStyle(color: Colors.blue)),
                          Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Deal products
              Row(
                children: [
                  Expanded(
                    child: _buildProductCard(
                      'Women Printed Kurta',
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      '₹1500',
                      '24% OFF',
                      4.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildProductCard(
                      'HRX by Hrithik Roshan',
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      '₹2499',
                      '20% OFF',
                      4.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Special offers
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special Offers',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'We make sure you get the offer you need at best prices',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Flat and Heels
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Flat and Heels',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Stand a chance to get rewarded',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      ),
                      child: const Text('Visit now →'),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Trending Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trending Products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            'Last Date 29/03/22',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.TRENDING_PROD_ROUTE_NAME);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink[50],
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    child: const Row(
                      children: [
                        Text('View all', style: TextStyle(color: Colors.pink)),
                        Icon(Icons.arrow_forward, size: 16, color: Colors.pink),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Trending Products Grid
              Row(
                children: [
                  Expanded(
                    child: _buildProductCard(
                      'IWC Schaffhausen 2021 Pilot\'s Watch "SIHH 2019" 44mm',
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      '₹620',
                      '60% OFF',
                      4.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildProductCard(
                      'Labbit White Sneakers For Men and Female',
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      '₹650',
                      '55% OFF',
                      4.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Summer Sale
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Center(
                        child: Image.network(
                          'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                          width: 200,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // New Arrivals
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Arrivals',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Summer\'25 Collections',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    child: const Row(
                      children: [
                        Text('View all'),
                        Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sponsored
              const Text(
                'Sponsered',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              // Sponsored Banner
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: Colors.white.withOpacity(0.8),
                        child: const Text(
                          'UP TO\n50% OFF',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Last banner
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'up to 50% Off',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.shopping_cart_outlined),
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
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String imageUrl, String price, String discount, double rating) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Neque porro quisquam est qui dolorem ipsum quia',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        discount,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
                              : (index < rating ? Icons.star_half : Icons.star_border),
                          color: Colors.amber,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '($rating)',
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
        ],
      ),
    );
  }
}