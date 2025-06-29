import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomBannerWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const CustomBannerWidget({
    Key? key,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150, // Adjust height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          // You can add a child here for text or other content on top of the banner
        ),
      ),
    );
  }
} 