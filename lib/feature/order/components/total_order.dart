import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/components/data_api/orderdetail_plus.dart';

class TotalOrder extends StatefulWidget {
  final String cusid;
  final String orderid;

  const TotalOrder({super.key, required this.cusid, required this.orderid});

  @override
  _TotalOrderState createState() => _TotalOrderState();
}

class _TotalOrderState extends State<TotalOrder> {
  late Future<List<Map<String, dynamic>>> customerFuture;

  @override
  void initState() {
    super.initState();
    customerFuture = fetchData(widget.cusid, widget.orderid);
  }

  String formatCurrency(int price) {
    final formatCurrency = NumberFormat("#,###", "vi_VN");
    return formatCurrency.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: customerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Không thể tải dữ liệu khách hàng');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Không tìm thấy thông tin khách hàng');
        }

        final customer = snapshot.data!.first;
        int totalitem = customer['order_price'];
        int deliveryfee = customer['deliveryFee'];
        int total = customer['total_price'];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD3D3D3)),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tổng cộng",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF808080),
                    fontFamily: 'Roboto'),
              ),
              const Divider(height: 16, color: Color(0xFFD3D3D3)),
              Row(
                children: [
                  const Text(
                    "Tổng sản phẩm:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${formatCurrency(totalitem)}đ",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    "Phí vận chuyển:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${formatCurrency(deliveryfee)}đ",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    "Tổng đơn hàng:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${formatCurrency(total)}đ",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE1001A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
