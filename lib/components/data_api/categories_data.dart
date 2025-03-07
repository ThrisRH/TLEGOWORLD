import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchCategories {
  static Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://3.25.92.254:5000/api/categories'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        return data.values.map((item) {
          return {
            "image": item["imgurl"] ?? "https://via.placeholder.com/150",
            "title": item["cate_name"] ?? "Không có tên",
            "count": item["cateitem_count"] ?? 0,
          };
        }).toList();
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      return [];
    }
  }

  static fetchCategories() {}
}
