import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>> fetchData(String proid) async {
  print("Category received: $proid"); // In cate ra console

  final response =
      await http.get(Uri.parse('http://3.25.92.254:5000/api/products'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    final transactions = data.entries
        .map((entry) => entry.value as Map<String, dynamic>)
        .toList();

    return transactions.where((transaction) {
      return transaction['pro_ID'].toString() == proid;
    }).toList();
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}
