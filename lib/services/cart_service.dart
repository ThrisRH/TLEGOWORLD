import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  static Future<List<dynamic>> getUserCart(String userId) async {
    try {
      final response = await http
          .get(Uri.parse("http://3.25.92.254:5000/api/carts/$userId"));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          // print(data);
          return data;
        } else if (data is Map) {
          print(data.values.toList());
          return data.values.toList();
        } else {
          throw Exception("Dữ liệu không hợp lệ");
        }
      } else {
        throw Exception("Lỗi: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy giỏ hàng: $e");
      return [];
    }
  }

  static Future<bool> addUserCart(String userId, String pro_ID) async {
    try {
      final response = await http.post(
        Uri.parse("http://3.25.92.254:5000/api/carts/addCart"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "pro_ID": pro_ID,
        }),
      );
      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        return true; // Thêm thành công
      } else {
        return false; // Lỗi từ server
      }
    } catch (e) {
      print("Lỗi khi lấy giỏ hàng: $e");
      return false;
    }
  }

  static Future<bool> clearUserCart(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'http://3.25.92.254:5000/api/carts/$userId',
        ),
      );

      if (response.statusCode == 200) {
        return true; // Thêm thành công
      } else {
        return false; // Lỗi từ server
      }
    } catch (e) {
      print("Lỗi khi xóa cart: $e");
      return false;
    }
  }
}
