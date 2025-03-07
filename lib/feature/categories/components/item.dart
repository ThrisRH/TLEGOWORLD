import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int itemCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Bo góc nhẹ
            child: Image.network(
              imageUrl,
              width: 112,
              height: 89,
              fit: BoxFit.cover, // Giúp ảnh hiển thị đẹp hơn
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "lib/assets/images/placeholder.png",
                  width: 112,
                  height: 89,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF808080),
                fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            '$itemCount sản phẩm',
            style: const TextStyle(color: Color(0xFF808080), fontSize: 9),
          ),
        ],
      ),
    );
  }
}
