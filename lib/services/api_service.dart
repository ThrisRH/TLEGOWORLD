import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://provinces.open-api.vn/api";

  // Lấy danh sách Tỉnh/Thành phố
  static Future<List<dynamic>> getProvinces() async {
    final response = await http.get(Uri.parse("$baseUrl?p=1"));

    if (response.statusCode == 200) {
      // Đảm bảo đọc đúng UTF-8
      String utf8Body = utf8.decode(response.bodyBytes);
      return jsonDecode(utf8Body);
    } else {
      throw Exception("Lỗi tải danh sách tỉnh/thành");
    }
  }

  // Lấy danh sách Quận/Huyện theo ID Tỉnh/Thành phố
  static Future<List<dynamic>> getDistricts(String provinceId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/p/$provinceId?depth=2"));

      if (response.statusCode == 200) {
        String utf8Body = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(utf8Body);

        if (data.containsKey('districts')) {
          return data['districts']; // Trả về danh sách quận/huyện
        } else {
          throw Exception("Không tìm thấy danh sách quận/huyện");
        }
      } else {
        throw Exception("Lỗi khi tải danh sách quận/huyện");
      }
    } catch (e) {
      print("Lỗi tải quận/huyện: $e");
      throw Exception("Lỗi khi tải danh sách quận/huyện");
    }
  }

  // Lấy danh sách Phường/Xã theo ID Quận/Huyện
  static Future<List<dynamic>> getWards(int districtId) async {
    final response =
        await http.get(Uri.parse("$baseUrl/d/$districtId?depth=2"));
    if (response.statusCode == 200) {
      String utf8Body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(utf8Body);
      return data['wards'];
    } else {
      throw Exception("Lỗi khi tải danh sách phường/xã");
    }
  }
}
