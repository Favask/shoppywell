import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../widget/banner_carousel_widget.dart';
import '../../widget/category_list_widget.dart';
import '../../widget/deal_of_day_widget.dart';
import '../../widget/product_grid_widget.dart';
import '../../widget/trending_products_widget.dart';
import '../../widget/special_offers_widget.dart';
import '../../widget/flat_and_heels_widget.dart';
import '../../widget/custom_banner_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true; // Keep the state alive when used in tabs

  @override
  void initState() {
    super.initState();
    // Dispatch LoadHomeData event when the page is initialized
    context.read<HomeBloc>().add(const LoadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoppywell'), // Replace with actual logo/title
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement drawer navigation
          },
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {
          //     // TODO: Implement search functionality
          //   },
          // ),
        
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomePageShimmerLoading(); // Use Shimmer loading widget
          } else if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const RefreshHomeData());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(), // Allow pull-to-refresh even if content is not full screen
                children: [
                                    const SizedBox(height: 16.0),

                  // Category Row
                  CategoryListWidget(
                    categories: state.categories,
                    onCategorySelected: (categoryId) {
                      // TODO: Implement navigation to category page
                      print('Category selected: $categoryId');
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Banner Carousel
                  BannerCarouselWidget(
                    banners: state.banners,
                    onBannerTap: (link) {
                      // TODO: Implement deep linking
                      print('Banner tapped: $link');
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Deal of the Day
                  if (state.deals.isNotEmpty && state.featuredProducts.isNotEmpty) // Assuming featured products are shown in Deal of the Day
                    DealOfDayWidget(
                      deal: state.deals.first, // Assuming only one active deal for now
                      products: state.featuredProducts.take(2).toList(), // Show a couple of products from featured for the deal
                    ),
                  const SizedBox(height: 16.0),
                  // Featured Products Grid
                  ProductGridWidget(
                    title: 'All Featured',
                    products: state.featuredProducts,
                    onSeeAllTap: () {
                      // TODO: Implement navigation to featured products listing
                      print('See All Featured tapped');
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Special Offers Section
                  const SpecialOffersWidget(), // This widget does not depend on fetched data currently
                  const SizedBox(height: 16.0),
                  // Flat and Heels Section
                  // Assuming a specific banner for this section, replace with actual data if available
                  FlatAndHeelsWidget(
                    imageUrl: 'https://dummyimage.com/500x400/ff6699/000', // Replace with actual image URL
                    title: 'Flat and Heels',
                    subtitle: 'Stand a chance to get rewarded',
                    ctaText: 'Visit now →',
                    onCtaTap: () {
                      // TODO: Implement navigation to Flat and Heels category/listing
                      print('Flat and Heels Visit now tapped');
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Trending Products
                   TrendingProductsWidget(
                    products: state.trendingProducts,
                    onSeeAllTap: () {
                       // TODO: Implement navigation to trending products listing
                       print('See All Trending tapped');
                    },
                  ),
                  const SizedBox(height: 16.0),
                   // Hot Summer Sale Banner
                   // Assuming a specific banner for this section, replace with actual data if available
                   CustomBannerWidget(
                    imageUrl: 'https://dummyimage.com/500x400/ff6699/000', // Replace with actual image URL
                     onTap: (){
                       // TODO: Implement navigation/action for summer sale banner
                       print('Summer Sale banner tapped');
                     },
                   ),
                   const SizedBox(height: 16.0),
                  // New Arrivals (Using ProductGridWidget)
                   ProductGridWidget(
                    title: 'New Arrivals',
                    products: state.trendingProducts, // Assuming trending products for New Arrivals for now
                    onSeeAllTap: () {
                      // TODO: Implement navigation to new arrivals listing
                       print('See All New Arrivals tapped');
                    },
                  ),
                   const SizedBox(height: 16.0),
                ].where((widget) => !(widget is SizedBox && widget.height == 0.0)).toList(), // Filter out SizedBox.shrink() if any widget returns it
              ),
            );
          } else if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(const LoadHomeData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Container(); // Initial state or unhandled states
        },
      ),
    );
  }
}

// Shimmer loading widget for the Home Page
class HomePageShimmerLoading extends StatelessWidget {
  const HomePageShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          // Shimmer for Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 30, backgroundColor: Colors.white),
                        const SizedBox(height: 4),
                        Container(width: 50, height: 10, color: Colors.white),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Shimmer for Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 180.0,
              decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          // Shimmer for Section Title
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
             child: Container(
               width: 150,
               height: 20,
               color: Colors.white,
             ),
           ),
          // Shimmer for Products (Horizontal List)
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Placeholder count
                 itemBuilder: (context, index) {
                  return Container(
                     width: 160,
                     margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                   );
                 }
              )
            ),
          ),
           // Shimmer for Section Title
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
             child: Container(
               width: 150,
               height: 20,
               color: Colors.white,
             ),
           ),
           // Shimmer for Product Grid
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: 4, // Placeholder count
              itemBuilder: (context, index) {
                return Container(
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                   ),
                );
              },
            ),
          ),
           // Shimmer for Full Width Banner
             Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 150.0,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ].where((widget) => !(widget is SizedBox )).toList(),
      ),
    );
  }
}