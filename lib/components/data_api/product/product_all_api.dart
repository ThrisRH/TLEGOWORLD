import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>> fetchDataProductall() async {
  final response =
      await http.get(Uri.parse('http://3.25.92.254:5000/api/products'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;

    return data.values.map((item) {
      return {
        "pro_ID": item["pro_ID"] ?? "Không có tên",
        "pro_img": item["pro_img"] ?? "Không có tên",
        "block_count": item["block_count"] ?? "Không có tên",
        "cate_id": item["cate_id"] ?? "Không có tên",
        "pro_name": item["pro_name"] ?? "Không có tên",
      };
    }).toList();
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}
