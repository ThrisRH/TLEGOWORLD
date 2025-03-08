import 'package:flutter/material.dart';

class ListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;

  const ListAppBar({super.key, required this.title, this.onBackPress});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60), // Định chiều cao AppBar
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white, // Nền trắng
          borderRadius: BorderRadius.circular(30), // Bo góc AppBar
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nút Back
            GestureDetector(
              onTap: onBackPress ?? () => Navigator.pop(context),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            // Tiêu đề
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE1001A),
              ),
            ),

            // Icon Giỏ hàng
            IconButton(
              icon:
                  const Icon(Icons.shopping_bag_outlined, color: Colors.black),
              onPressed: () {
                // Điều hướng đến giỏ hàng
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
