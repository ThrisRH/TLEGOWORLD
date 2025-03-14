import 'package:flutter/material.dart';

class OrderStatusBar extends StatelessWidget {
  final String orderId;
  final String orderStatus;

  const OrderStatusBar(
      {super.key, required this.orderId, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    // Xác định trạng thái đơn hàng
    bool isWaiting = orderStatus.toLowerCase() == "chờ vận chuyển";
    bool isShipping = orderStatus.toLowerCase() == "đang vận chuyển";
    bool isDelivered = orderStatus.toLowerCase() == "nhận hàng";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderId,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1C),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildStatusIcon(
                icon: Icons.inventory_2,
                label: "Chờ vận\nchuyển",
                isActive: isWaiting || isShipping || isDelivered,
              ),
            ),
            _buildLine(
                isActive: isShipping || isDelivered), // Không dùng Expanded
            Expanded(
              child: _buildStatusIcon(
                icon: Icons.local_shipping,
                label: "Đang vận\nchuyển",
                isActive: isShipping || isDelivered,
              ),
            ),
            _buildLine(isActive: isDelivered), // Không dùng Expanded
            Expanded(
              child: _buildStatusIcon(
                icon: Icons.home,
                label: "Nhận hàng",
                isActive: isDelivered,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIcon(
      {required IconData icon, required String label, required bool isActive}) {
    return Column(
      children: [
        Icon(icon,
            size: 28,
            color:
                isActive ? const Color(0xFF0051BA) : const Color(0xFFD3D3D3)),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: isActive ? Color(0xFFF0051BA) : Color(0xFFD3D3D3)),
        ),
      ],
    );
  }

  Widget _buildLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 3,
        color: isActive ? Color(0xFF0051BA) : Color(0xFFD3D3D3),
      ),
    );
  }
}
