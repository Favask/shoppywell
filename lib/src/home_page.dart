import 'package:flutter/material.dart';
import 'package:shoppywell/src/widgets/category_item.dart';
import 'package:shoppywell/src/widgets/product_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Placeholder data for categories
  final List<Map<String, dynamic>> categories = const [
    {'label': 'Beauty', 'icon': Icons.category},
    {'label': 'Fashion', 'icon': Icons.checkroom},
    {'label': 'Kids', 'icon': Icons.child_care},
    {'label': 'Mens', 'icon': Icons.male},
    {'label': 'Womens', 'icon': Icons.female},
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement menu action
          },
        ),
        title: Image.asset(
          'assets/images/shopywell_logo.png', // Assuming you have a logo image here
          height: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // TODO: Implement profile action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any Product...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.mic_none),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'All Featured',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Categories will go here
            SizedBox(
              height: 100, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    label: categories[index]['label'],
                    icon: categories[index]['icon'],
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '50-40% OFF Banner', // Placeholder for the banner text
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent, // Placeholder color based on the image
                ),
              ),
            ),
            // Banner will go here
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.pink[100], // Placeholder color based on the image
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Stack(
                children: [
                  // TODO: Add background image for the banner
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '50-40% OFF',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Now in (product)\nAll colours',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 10),
                        // TODO: Add Shop Now button
                        Text(
                          'Shop Now →',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Deal of the Day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Timer and View all button will go here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.blue[800], // Placeholder color
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '22h 55m 20s remaining', // Placeholder timer text
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[800], // Placeholder color
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement view all action
                    },
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(color: Colors.blue[800]), // Placeholder color
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.blue[800], // Placeholder color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Deal of the Day products will go here
            SizedBox(
              height: 250, // Adjust height to accommodate product item size
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder count
                itemBuilder: (context, index) {
                  // Placeholder product data
                  return ProductItem(
                    imageUrl: 'https://via.placeholder.com/150', // Placeholder image
                    name: 'Product Name',
                    description: 'Product description...',
                    currentPrice: '₹1500',
                    originalPrice: '₹2499',
                    discount: '40%Off',
                    rating: 4.5,
                    reviews: 56890,
                    productId: 'deal_${index + 1}', // Add product ID for navigation
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Special Offers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Special Offers content will go here
            SizedBox(
              height: 150, // Adjust height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Placeholder for the first offer (Shopping bags)
                  Container(
                    width: 250, // Adjust width as needed
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.purple[100], // Placeholder color
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(child: Text('Special Offers Banner 1')),
                  ),
                  // Placeholder for the second offer (Flat and Heels)
                  Container(
                    width: 250, // Adjust width as needed
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.pink[100], // Placeholder color
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(child: Text('Special Offers Banner 2')),
                  ),
                  // Add more offers if needed
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Trending Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Trending Products content will go here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Products', // Repeat title for clarity in the row
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement view all action
                    },
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(color: Colors.blue[800]), // Placeholder color
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.blue[800], // Placeholder color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250, // Adjust height to accommodate product item size
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder count
                itemBuilder: (context, index) {
                  // Placeholder product data
                  return ProductItem(
                    imageUrl: 'https://via.placeholder.com/150', // Placeholder image
                    name: 'Trending Product',
                    description: 'Trending description...',
                    currentPrice: '₹650',
                    originalPrice: '₹1599',
                    discount: '60% off',
                    rating: 4.0,
                    reviews: 12345,
                    productId: 'trending_${index + 1}', // Add product ID for navigation
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'New Arrivals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // New Arrivals content will go here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Arrivals', // Title
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Summer\' 25 Collections', // Subtitle
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement view all action
                    },
                    child: const Row(
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(color: Colors.red), // Color based on image
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.red, // Color based on image
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250, // Adjust height to accommodate product item size
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder count
                itemBuilder: (context, index) {
                  // Placeholder product data
                  return ProductItem(
                    imageUrl: 'https://via.placeholder.com/150', // Placeholder image
                    name: 'New Product',
                    description: 'New collection item...',
                    currentPrice: '₹750',
                    originalPrice: '₹1999',
                    discount: '50% off',
                    rating: 4.2,
                    reviews: 9876,
                    productId: 'new_${index + 1}', // Add product ID for navigation
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Sponsored',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Sponsored content will go here
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.brown[100], // Placeholder color based on the image
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  // TODO: Add background image for the sponsored banner
                  Text(
                    'UP TO\n50% OFF',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Assuming white text on the image
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        Text(
                          'up to 50% Off', // Text below the banner
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87, // Placeholder color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.black87, // Placeholder color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some spacing at the bottom
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red, // Based on the image
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Assuming Home is the initial selected item
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
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
        onTap: (index) {
          // TODO: Implement navigation
        },
      ),
    );
  }
} 