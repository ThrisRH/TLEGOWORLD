import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final int sold;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.sold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: const Color(0xFFE1001A), width: 1), // Viền xanh
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Hình ảnh sản phẩm
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 132,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          // Tiêu đề sản phẩm
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF0051BA),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Giá tiền
          Align(
            alignment: Alignment.centerLeft, // Đẩy sát lề trái
            child: Text(
              '$priceđ',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFE1001A),
              ),
            ),
          ),

          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerRight, // Căn lề phải
            child: Text(
              'Đã bán $sold đơn',
              style: const TextStyle(fontSize: 10, color: Color(0xFF28282B)),
            ),
          ),
        ],
      ),
    );
  }
}
