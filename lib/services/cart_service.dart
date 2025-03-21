import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CartService {
  static Future<List<dynamic>> getUserCart(String userId) async {
    try {
      final response = await http
          .get(Uri.parse("http://192.168.139.147:5000/api/carts/$userId"));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          // print(data);
          return data;
        } else if (data is Map) {
          debugPrint('data: ${data.values.toList()}');
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
        return true; // Xóa thành công
      } else {
        return false; // Lỗi từ server
      }
    } catch (e) {
      print("Lỗi khi xóa cart: $e");
      return false;
    }
  }

  static Future<bool> deleteProductInCart(String userId, String proId) async {
    try{
      final response = await http.delete(
        Uri.parse(
          'http://192.168.139.147:5000/api/carts/$userId/$proId',
        ),
      );

       if (response.statusCode == 200) {
        return true; // Xóa thành công
      } else {
        return false; // Lỗi từ server
      }
    }
    catch (e){
      print("Lỗi khi xóa cart: $e");
      return false;
    }
  }

 static Future<bool> updateProductQuantity(String userId, String cartProId, int quantity) async {
    final url = Uri.parse('http://192.168.139.147:5000/api/carts/update/$userId/$cartProId'); // Thay API URL
    print(quantity);
    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"pro_quantity": quantity}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Lỗi cập nhật số lượng: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
      return false;
    }
  }
}
