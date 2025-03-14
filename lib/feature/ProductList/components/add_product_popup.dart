import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/components/component/QuantitySelector.dart';
import 'package:tlego_world/components/component/button.dart';

class BuyNowPopup extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final VoidCallback onConfirm;

  const BuyNowPopup({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD3D3D3), width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    productImage,
                    height: 152,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 12), // Tạo khoảng cách giữa ảnh và text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0051BA),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${NumberFormat("#,###", "vi_VN").format(productPrice)}đ',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE1001A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            children: [
              QuantitySelector(
                initialValue: 1,
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          RedButton(
            text: 'THÊM VÀO GIỎ HÀNG',
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
