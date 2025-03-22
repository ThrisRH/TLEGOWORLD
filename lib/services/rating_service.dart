import 'dart:convert';
import 'package:http/http.dart' as http;

class RatingService {
  static String localHost = "192.168.1.73";

  // Hàm lấy danh sách đánh giá theo pro_ID
  static Future<List<Map<String, dynamic>>?> fetchReviews(String proID) async {
    final url = Uri.parse("http://$localHost:5000/api/rating/getById/$proID");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Map<String, dynamic>> fetchedReviews =
            List<Map<String, dynamic>>.from(data["orders"]);

        return fetchedReviews;
      } else {
        print("Lỗi: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
      return null;
    }
  }
}
