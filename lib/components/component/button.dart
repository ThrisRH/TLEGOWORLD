import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Thêm tham số text để có thể chỉnh nội dung nút

  const RedButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Nút chiếm hết chiều rộng
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE1001A),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ), // Tăng chiều cao cho đẹp
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text, // Hiển thị nội dung động
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ShoppingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShoppingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: SvgPicture.asset(
            'lib/assets/svg/components/shopping_icon.svg',
          ),
        ),
      ),
    );
  }
}
