import 'package:flutter/material.dart';
import 'package:tlego_world/components/data_api/orderdetail_data.dart';
import 'package:tlego_world/components/component/search.dart';
import 'package:tlego_world/feature/order/components/product_cart.dart';
import 'package:tlego_world/feature/order/view/order_detail.dart';
import 'package:tlego_world/services/auth_helper.dart';

void main() {
  runApp(const OrderMain());
}

class OrderMain extends StatelessWidget {
  const OrderMain({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = AuthHelper.getUserId(); // Lấy userId từ AuthHelper

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12), // Thêm padding 12
            child: Column(
              children: [
                const SizedBox(height: 35),
                SearchBarbtn(onCartTap: () {}),

                // Gọi API & hiển thị danh sách động
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchData(userId), // Truyền userId vào API
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Lỗi: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("Không có đơn hàng nào"));
                      }

                      final orders = snapshot.data!;
                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];

                          return OrderItem(
                            imageUrl: order['order_img'] ?? "",
                            title: order['pro_name'] ?? "Sản phẩm không tên",
                            price: "${order['total_price'] ?? '0'}đ",
                            status: order['order_status'] ?? "Chưa rõ",
                            deliveryDate:
                                order['order_expected_day'] ?? "Chưa có ngày",
                            onCancel: () {}, // Xử lý hủy đơn
                            onDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetail(orderData: order),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
