import 'package:flutter/material.dart';
import 'package:tlego_world/components/component/ListBar.dart';
import 'package:tlego_world/feature/order/components/info_cus.dart';
import 'package:tlego_world/feature/order/components/order_item.dart';
import 'package:tlego_world/feature/order/components/status_order.dart';
import 'package:tlego_world/feature/order/components/total_order.dart';

class OrderDetail extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetail({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    String orderId = orderData['order_id'] ?? "Không có";
    String orderStatus = orderData['order_status'] ?? "Chưa rõ";
    String cusid = orderData['cus_id'] ?? "Chưa rõ";
    String date = orderData['order_date'] ?? "Chưa rõ";

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
              InvoiceComponent(
                orderId: orderId,
                date: date,
              ),
              const SizedBox(height: 32),
              TotalOrder(
                cusid: cusid,
                orderid: orderId,
              )
            ],
          ),
        ),
      ),
    );
  }
}
