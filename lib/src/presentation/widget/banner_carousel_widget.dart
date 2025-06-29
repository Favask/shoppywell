import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoppywell/src/domain/entities/app_banner.dart';

class BannerCarouselWidget extends StatelessWidget {
  final List<AppBanner> banners;
  final Function(String) onBannerTap;

  const BannerCarouselWidget({
    Key? key,
    required this.banners,
    required this.onBannerTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return const SizedBox.shrink(); // Hide if no banners
    }

    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];
        return GestureDetector(
          onTap: () => onBannerTap(banner.ctaLink),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(banner.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Optional: Add overlay for text readability
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: TextStyle(
                          color: banner.textColor.isNotEmpty ? Color(int.parse(banner.textColor),) : Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        banner.subtitle,
                        style: TextStyle(
                          color: banner.textColor.isNotEmpty ? Color(int.parse(banner.textColor)) : Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      if (banner.ctaText.isNotEmpty)
                        ElevatedButton(
                          onPressed: () => onBannerTap(banner.ctaLink),
                          child: Text(banner.ctaText),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 180.0, // Adjust height as needed
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
} 