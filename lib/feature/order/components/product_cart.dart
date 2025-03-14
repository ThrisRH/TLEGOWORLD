import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String status;
  final String deliveryDate;
  final VoidCallback onCancel;
  final VoidCallback onDetails;

  const OrderItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.status,
    required this.deliveryDate,
    required this.onCancel,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hàng đầu tiên: Ảnh + Tiêu đề + Tổng tiền
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                width: 64,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                // Đảm bảo không bị tràn khi tiêu đề dài
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1C1C1C),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          "Tổng Tiền:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE1001A),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE1001A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Trạng thái và ngày giao hàng
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 219, 186, 21),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "Dự kiến giao: $deliveryDate",
                style: const TextStyle(
                  color: Color(0xFF808080),
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Hai nút Hủy đơn và Chi tiết
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFE1001A),
                  side: const BorderSide(color: Color(0xFFE1001A)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 6, horizontal: 8), // Chỉnh padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6), // Chỉnh border radius
                  ),
                ),
                child: const Text(
                  "HỦY ĐƠN",
                  style: TextStyle(
                    fontSize: 12, // Điều chỉnh lại nếu cần
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE1001A),
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE1001A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                ),
                child: const Text(
                  "CHI TIẾT",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
