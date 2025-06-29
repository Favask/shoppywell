import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  // In a real app, you would use an icon or image path here
  final IconData icon;

  const CategoryItem({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300], // Placeholder background
            child: Icon(icon, size: 30, color: Colors.white), // Placeholder icon
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
} 