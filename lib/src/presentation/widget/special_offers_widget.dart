import 'package:flutter/material.dart';

class SpecialOffersWidget extends StatelessWidget {
  const SpecialOffersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.purple.shade100, // Example background color
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            // Replace with actual icon/image if available
            Icon(
              Icons.card_giftcard,
              size: 40,
              color: Colors.purple.shade700,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Special Offers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'We make sure you get the offer you need at best prices',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.purple.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 