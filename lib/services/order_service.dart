// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  static const String localHost = "3.25.92.254";

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
        Uri.parse("http://3.25.92.254:5000/api/orderitem"),
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
        print(data['order_id']);
        return "success"; // Trả về order_id nếu thành công
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
      required String payment_method,
      required String payment_status,
      required String pro_name,
      required double total_price}) async {
    try {
      print("📝 Order Details Data:");
      print("cus_id: $cus_id");
      print("deliveryFee: $deliveryFee");
      print("order_date: $order_date");
      print("order_expected_day: $order_expected_day");
      print("order_id: $order_id");
      print("order_img: $order_img");
      print("order_price: $order_price");
      print("order_status: $order_status");
      print("payment_method: $payment_method");
      print("payment_status: $payment_status");
      print("pro_name: $pro_name");
      print("total_price: $total_price");

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
          "payment_method": payment_method,
          "payment_status": payment_status,
          "pro_name": pro_name,
          "total_price": total_price
        }),
      );

      if (response.statusCode == 201) {
        return "success"; // Trả về order_id nếu thành công
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
    final url =
        Uri.parse("http://3.25.92.254:5000/api/orderitem/rating/update");

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

  static Future<bool> createOrderForGuest({
    required String pro_ID,
    required String order_id,
    required String guest_phone,
    required String guest_fullname,
    required String guest_provicecity,
    required String guest_district,
    required String guest_wardcommue,
    required String guest_streethouse,
    required double deliveryFee,
    required String order_date,
    required String order_img,
    required double order_price,
    required String order_status,
    required String pro_name,
    required String payment_method,
    required String payment_status,
    required double total_price,
    required int order_quantity,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://3.25.92.254:5000/api/orderitem/forguest"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "pro_ID": pro_ID,
          "order_id": order_id,
          "guest_phone": guest_phone,
          "guest_fullname": guest_fullname,
          "guest_provicecity": guest_provicecity,
          "guest_district": guest_district,
          "guest_wardcommue": guest_wardcommue,
          "guest_streethouse": guest_streethouse,
          "deliveryFee": deliveryFee,
          "order_date": order_date,
          "order_img": order_img,
          "order_price": order_price,
          "order_status": order_status,
          "pro_name": pro_name,
          "payment_method": payment_method,
          "payment_status": payment_status,
          "total_price": total_price,
          "order_quantity": order_quantity,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print(data);
        return true; // Trả về order_id nếu thành công
      } else {
        Exception("Lỗi khi tạo đơn hàng: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
      return false;
    }
  }
}
