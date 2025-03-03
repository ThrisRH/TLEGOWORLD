import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int itemCount;
  final VoidCallback onTap;

  const CategoryCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.itemCount,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(
                imageUrl,
                width: 100, // Chiều rộng đầy đủ của widget cha
                height: 100, // Chiều cao cố định
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(title),
            const SizedBox(
              height: 2,
            ),
            Text('$itemCount')
          ],
        ),
      ),
    );
  }
}
