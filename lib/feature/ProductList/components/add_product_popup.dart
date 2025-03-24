import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/components/component/QuantitySelector.dart';
import 'package:tlego_world/components/component/button.dart';

class BuyNowPopup extends StatefulWidget {
  final String productName;
  final String productImage;
  final bool isCart;
  final int productPrice;
  final Function(int) onConfirm; // Nhận số lượng khi bấm nút

  const BuyNowPopup({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.onConfirm,
    required this.isCart,
  });

  @override
  _BuyNowPopupState createState() => _BuyNowPopupState();
}

class _BuyNowPopupState extends State<BuyNowPopup> {
  int quantity = 1; // Số lượng mặc định

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
                    widget.productImage,
                    height: 152,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
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
                      '${NumberFormat("#,###", "vi_VN").format(widget.productPrice)}đ',
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
          const SizedBox(height: 40),
          Row(
            children: [
              QuantitySelector(
                initialValue: quantity,
                onChanged: (value) {
                  setState(() {
                    quantity = value; // Cập nhật số lượng khi thay đổi
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          widget.isCart
              ? RedButton(
                  text: 'THÊM VÀO GIỎ HÀNG',
                  onPressed: () => widget
                      .onConfirm(quantity), // Truyền số lượng khi thêm vào giỏ
                )
              : RedButton(
                  text: 'MUA NGAY',
                  onPressed: () {
                    print("✅ Nút Mua ngay đã được bấm!");
                    print("✅ Số lượng đã chọn: $quantity");
                    widget.onConfirm(quantity);
                  },
                ),
        ],
      ),
    );
  }
}
