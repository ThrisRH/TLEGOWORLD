// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/data_api/add_rating_data.dart';
import 'package:tlego_world/components/data_api/delivered_order_data.dart';
import 'package:tlego_world/components/data_api/orderdetail_data.dart';
import 'package:tlego_world/components/component/search.dart';
import 'package:tlego_world/feature/order/components/product_cart.dart';
import 'package:tlego_world/feature/order/components/rating.dart';
import 'package:tlego_world/feature/order/view/order_detail.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/order_service.dart';
import 'package:tlego_world/utils/format_currency.dart';

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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SearchBarbtn(onCartTap: () {}),

                  // Tab Bar để chọn loại đơn hàng
                  const TabBar(
                    labelColor: AppColor.darkBlue,
                    splashFactory:
                        NoSplash.splashFactory, // Tắt hiệu ứng khi bấm

                    tabs: [
                      Tab(text: "Đơn hàng của bạn"),
                      Tab(text: "Đơn hàng đã giao"),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        OrderList(userId: userId, isDelivered: false),
                        OrderList(userId: userId, isDelivered: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String userId;
  final bool isDelivered;

  const OrderList({super.key, required this.userId, required this.isDelivered});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: !isDelivered ? fetchData(userId) : fetchDeliveredOrders(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Lỗi: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Không có đơn hàng nào"));
        }

        // Lấy dữ liệu ban đầu
        final allOrders = snapshot.data!;

        // Khai báo danh sách orders trước
        List<Map<String, dynamic>> orders = [];

        if (!isDelivered) {
          orders = allOrders
              .where((order) => order['order_status'] != "nhận hàng")
              .toList();
        } else {
          orders = allOrders;
        }

        // Kiểm tra nếu không có đơn hàng
        if (orders.isEmpty) {
          return const Center(child: Text("Không có đơn hàng nào"));
        }

        void showRatingPopup(String proId, String orderId) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return RatingPopup(
                onSubmit: (int rating, String review) async {
                  await TransactionService.saveTransaction(
                    context: context,
                    proID: proId,
                    rating: rating,
                    review: review,
                  );
                  OrderService.updateRating(orderId, proId, true);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gửi đánh giá thành công!")),
                    );
                  }
                },
              );
            },
          );
        }

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return !isDelivered
                ? OrderItem(
                    imageUrl: order['order_img'] ?? "",
                    title: order['pro_name'] ?? "Sản phẩm không tên",
                    price: formatCurrency(order['total_price']),
                    status: order['order_status'] ?? "Đang chờ xác nhận",
                    isRated: false,
                    deliveryDate: order['order_expected_day'] ?? "Chưa có ngày",
                    cancelStatus: order['order_status'] != "Đang chờ xác nhận"
                        ? false
                        : true,
                    onCancel: () {}, // Xử lý hủy đơn
                    onDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetail(orderData: order),
                        ),
                      );
                    },
                    isDelivered: false,
                  )
                : OrderItem(
                    /// Đã hoàn thành đơn
                    imageUrl: order['pro_img'] ?? "",
                    title: order['pro_name'] ?? "Sản phẩm không tên",
                    price: formatCurrency(order['order_price']),
                    status: "Đã hoàn thành",
                    deliveryDate: order['order_expected_day'] ?? "Chưa có ngày",
                    cancelStatus: order['order_status'] != "Đang chờ xác nhận"
                        ? false
                        : true,
                    onCancel: () {}, // Xử lý hủy đơn
                    onDetails: () {
                      if (!order['rating']) {
                        showRatingPopup(order['pro_ID'],
                            order['order_id']); // Xử lý đánh giá
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Bạn đã đánh giá rồi!',
                            backgroundColor:
                                AppColor.darkBlue.withOpacity(0.8));
                      }
                    },
                    isDelivered: true,
                    isRated: order['rating'],
                  );
          },
        );
      },
    );
  }
}
