import 'dart:convert';
import 'package:http/http.dart' as http;

class CateService {
  Future<int> getCateCounter(String cartId) async {
    try {
      final response = await http.get(
          Uri.parse("http://3.25.92.254:5000/api/categories/counter/$cartId"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return data;
      } else {
        throw Exception("Lỗi: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin người dùng: $e");
      return 0;
    }
  }
}
