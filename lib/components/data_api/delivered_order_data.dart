import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchDeliveredOrders(String userId) async {
  final orderDetailResponse =
      await http.get(Uri.parse('http://3.25.92.254:5000/api/orderdetail'));

  if (orderDetailResponse.statusCode != 200) {
    throw Exception('Không thể tải dữ liệu đơn hàng');
  }

  final orderDetailData = json.decode(orderDetailResponse.body) as Map<String, dynamic>;

  // Lọc ra các order_id có userId và trạng thái "nhận hàng"
  final completedOrderIds = orderDetailData.entries
      .where((entry) =>
          entry.value['cus_id'] == userId &&
          entry.value['order_status'] == "nhận hàng")
      .map((entry) => entry.value['order_id'].toString())
      .toList();

   if (completedOrderIds.isEmpty) {
    return []; // Không có đơn hàng nào hoàn thành
  }

  // Lấy danh sách orderitem
  final orderItemResponse =
      await http.get(Uri.parse('http://3.25.92.254:5000/api/orderitem'));

  if (orderItemResponse.statusCode != 200) {
    throw Exception('Không thể tải dữ liệu sản phẩm');
  }

  final orderItemData = json.decode(orderItemResponse.body) as Map<String, dynamic>;

  final completedOrderItems = orderItemData.entries
      .where((entry) => completedOrderIds.contains(entry.value['order_id']))
      .map((entry) => entry.value as Map<String, dynamic>)
      .toList();

  print(orderItemData);
  print(completedOrderItems);
  return completedOrderItems;
}