// ignore_for_file: avoid_print, unused_import

import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static String localHost = "192.168.1.73";
  static Future<Map<String, dynamic>?> getProByID(String proId) async {
    try {
      final response = await http
          .get(Uri.parse("http://$localHost:5000/api/products/$proId"));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception("Lỗi: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy giỏ hàng: $e");
      return null;
    }
  }
}
