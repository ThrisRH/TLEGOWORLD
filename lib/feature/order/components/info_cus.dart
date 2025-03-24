import 'package:flutter/material.dart';
import 'package:tlego_world/components/data_api/customer_data.dart';

class CustomerInfo extends StatefulWidget {
  final String cusid;

  const CustomerInfo({super.key, required this.cusid});

  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  late Future<List<Map<String, dynamic>>> customerFuture;

  @override
  void initState() {
    super.initState();
    customerFuture = fetchData(widget.cusid);
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
        String phone = customer['cus_phone'] ?? 'Không có';
        String address = customer['cus_address'] ?? 'Không có';
        String paymentMethod =
            "Thanh toán khi nhận hàng"; // Giả định phương thức thanh toán

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
                "Thông tin giao nhận",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF808080),
                    fontFamily: 'Roboto'),
              ),
              const Divider(height: 16, color: Color(0xFFD3D3D3)),
              Text(
                "(+84) $phone",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
