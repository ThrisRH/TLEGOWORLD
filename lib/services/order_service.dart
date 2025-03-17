// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<String?> createOrderItem({
    required String order_id,
    required double order_price,
    required int order_quantity,
    required String order_name,
  }) async {
    print('📡 JSON gửi lên server: ${jsonEncode({
          "order_id": order_id,
          "order_price": order_price,
          "order_quantity": order_quantity,
          "order_name": order_name,
        })}');
    try {
      final response = await http.post(
        Uri.parse("http://3.25.92.254:5000/api/orderitem"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "order_id": order_id,
          "order_price": order_price,
          "order_quantity": order_quantity,
          "pro_name": order_name,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data["order_id"]; // Trả về order_id nếu thành công
      } else {
        throw Exception("Lỗi khi tạo đơn hàng: ${response.body}");
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
      return null;
    }
  }

  static Future<String?> createOrderDetails(
      {required String cus_id,
      required double deliveryFee,
      required String order_date,
      required String order_expected_day,
      required String order_id,
      required String order_img,
      required double order_price,
      required String order_status,
      required String pro_name,
      required double total_price}) async {
    try {
      print("""
  Order Details:
  - cus_id: $cus_id
  - deliveryFee: $deliveryFee
  - order_date: $order_date
  - order_expected_day: $order_expected_day
  - order_id: $order_id
  - order_img: $order_img
  - order_price: $order_price
  - order_status: $order_status
  - pro_name: $pro_name
  - total_price: $total_price
  """);
      final response = await http.post(
        Uri.parse("http://3.25.92.254:5000/api/orderdetail"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "cus_id": cus_id,
          "deliveryFee": deliveryFee,
          "order_date": order_date,
          "order_expected_day": order_expected_day,
          "order_id": order_id,
          "order_img": order_img,
          "order_price": order_price,
          "order_status": order_status,
          "pro_name": pro_name,
          "total_price": total_price
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data["order_id"]; // Trả về order_id nếu thành công
      } else {
        throw Exception("Lỗi khi tạo đơn hàng: ${response.body}");
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
      return null;
    }
  }
}
