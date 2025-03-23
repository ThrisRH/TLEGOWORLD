import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>> fetchDataProduct(String cate) async {
  print("Category received: $cate"); // In cate ra console

  final response =
      await http.get(Uri.parse('http://3.25.92.254:5000/api/products'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    final transactions = data.entries
        .map((entry) => entry.value as Map<String, dynamic>)
        .toList();

    return transactions.where((transaction) {
      return transaction['cate_id'].toString() == cate;
    }).toList();
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}
