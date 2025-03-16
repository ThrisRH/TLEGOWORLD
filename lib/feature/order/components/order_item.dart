import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/components/data_api/order_item_data.dart';

class InvoiceComponent extends StatefulWidget {
  final String orderId;
  final String date;

  const InvoiceComponent({Key? key, required this.orderId, required this.date})
      : super(key: key);

  @override
  _InvoiceComponentState createState() => _InvoiceComponentState();
}

class _InvoiceComponentState extends State<InvoiceComponent> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrderItems();
  }

  String formatCurrency(int price) {
    final formatCurrency = NumberFormat("#,###", "vi_VN");
    return formatCurrency.format(price);
  }

  Future<void> loadOrderItems() async {
    try {
      final data = await fetchData(widget.orderId);
      if (mounted) {
        setState(() {
          items = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.all(16), // Khoảng cách bên trong viền
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4), // Bo góc viền
              border: Border.all(color: Colors.grey, width: 1), // Viền màu xám
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Hóa đơn",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF808080)),
                    ),
                    const Spacer(),
                    Text(widget.date,
                        style: TextStyle(color: Color(0xFF808080))),
                  ],
                ),
                const Divider(height: 16, color: Color(0xFFD3D3D3)),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return buildProductItem(items[index]);
                  },
                ),
              ],
            ),
          );
  }

  Widget buildProductItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10), // Khoảng cách giữa các item
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh sản phẩm
          Image.network(
            item['pro_img'] ??
                "https://res.cloudinary.com/dcdaz0dzb/image/upload/v1741355025/6849b27b-c672-4066-af76-0658e85b1005.png",
            width: 76,
            height: 108,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 24),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['pro_name'] ?? "Tên sản phẩm",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                Text("Số lượng: ${item['order_quantity'] ?? 0}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 12),
                Text(
                  "${formatCurrency(item['order_price'] ?? 0)}đ",
                  style: const TextStyle(
                      color: Color(0xFFE1001A),
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
