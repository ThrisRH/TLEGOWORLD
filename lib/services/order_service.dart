// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  static const String localHost = "192.168.1.73";

  static Future<String?> createOrderItem({
    required String order_id,
    required double order_price,
    required int order_quantity,
    required String order_name,
    required String pro_ID,
    required String pro_img,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://$localHost:5000/api/orderitem"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "order_id": order_id,
          "order_price": order_price,
          "order_quantity": order_quantity,
          "pro_name": order_name,
          "pro_img": pro_img,
          "pro_ID": pro_ID
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

  static Future<bool> updateRating(
      String orderId, String proId, bool rating) async {
    final url = Uri.parse("http://$localHost:5000/api/orderitem/rating/update");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "order_id": orderId,
          "pro_ID": proId,
          "rating": rating,
        }),
      );

      if (response.statusCode == 200) {
        print("Cập nhật rating thành công!");
        return true;
      } else {
        print("Lỗi: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
      return false;
    }
  }
}
