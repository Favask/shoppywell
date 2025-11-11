import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../widget/banner_carousel_widget.dart';
import '../../widget/category_list_widget.dart';
import '../../widget/product_grid_widget.dart';
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
        actions: const [

        
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
                  // Featured Products Grid
                  ProductGridWidget(
                    title: 'All Featured',
                    products: state.featuredProducts,
                    onSeeAllTap: () {
                      // TODO: Implement navigation to featured products listing
                      print('See All Featured tapped');
                    },
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
                        const CircleAvatar(radius: 30, backgroundColor: Colors.white),
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
        ].where((widget) => widget is! SizedBox ).toList(),
      ),
    );
  }
}