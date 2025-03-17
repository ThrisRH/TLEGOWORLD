import 'package:flutter/material.dart';
import 'package:tlego_world/components/component/ListBar.dart';
import 'package:tlego_world/components/component/button.dart';
import 'package:tlego_world/components/data_api/add_rating_data.dart';
import 'package:tlego_world/components/data_api/delete_orderdetail.dart';
import 'package:tlego_world/feature/order/components/info_cus.dart';
import 'package:tlego_world/feature/order/components/order_item.dart';
import 'package:tlego_world/feature/order/components/rating.dart';
import 'package:tlego_world/feature/order/components/status_order.dart';
import 'package:tlego_world/feature/order/components/total_order.dart';

class OrderDetail extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const OrderDetail({super.key, required this.orderData});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool isDeleting = false;

  void handleDelete(String orderId) async {
    setState(() => isDeleting = true);

    try {
      bool deleteOrderItemSuccess = await deleteOrderItem(orderId);
      if (!deleteOrderItemSuccess) throw Exception("Xóa orderitem thất bại!");

      bool deleteOrderDetailSuccess = await deleteOrder(orderId);
      if (deleteOrderDetailSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Xóa đơn hàng thành công!")),
        );
        Navigator.pop(context);
      } else {
        throw Exception("Xóa orderdetail thất bại!");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }

    setState(() => isDeleting = false);
  }

  void showRatingPopup(String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RatingPopup(
          onSubmit: (int rating, String review) async {
            await TransactionService.saveTransaction(
              context: context,
              id: orderId,
              rating: rating,
              review: review,
            );
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

  @override
  Widget build(BuildContext context) {
    String orderId = widget.orderData['order_id'] ?? "Không có";
    String orderStatus = widget.orderData['order_status'] ?? "Chưa rõ";
    String cusid = widget.orderData['cus_id'] ?? "Chưa rõ";
    String date = widget.orderData['order_date'] ?? "Chưa rõ";
    String id = widget.orderData['id'] ?? "Chưa rõ";

    return Scaffold(
      appBar: const ListAppBar(title: 'CHI TIẾT ĐƠN HÀNG'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderStatusBar(orderId: orderId, orderStatus: orderStatus),
              const SizedBox(height: 32),
              CustomerInfo(cusid: cusid),
              const SizedBox(height: 32),
              InvoiceComponent(orderId: orderId, date: date),
              const SizedBox(height: 32),
              TotalOrder(cusid: cusid, orderid: orderId),
              const SizedBox(height: 32),
              if (orderStatus == "chờ vận chuyển" ||
                  orderStatus == "Đang chờ xác nhận")
                CancelButton(
                  onPressed: isDeleting ? null : () => handleDelete(orderId),
                  isDeleting: isDeleting,
                  text: 'Hủy đơn',
                )
              else if (orderStatus == "nhận hàng")
                RatingButton(
                  onPressed: () => showRatingPopup(orderId),
                  text: 'Đánh giá',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
