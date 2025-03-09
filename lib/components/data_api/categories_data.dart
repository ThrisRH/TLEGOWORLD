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
            "image": item["imgurl"] ??
                "https://res.cloudinary.com/dcdaz0dzb/image/upload/v1741319528/wkdf9oqfmsalior18bl0.png",
            "title": item["cate_name"] ?? "Không có tên",
            "count": item["cateitem_count"] ?? 0,
            "cate": item["cate_id"] ?? "Không có cate",
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
