import 'package:http/http.dart' as http;

Future<bool> deleteOrder(String orderId) async {
  final response = await http.delete(
    Uri.parse('http://3.25.92.254:5000/api/orderdetail/$orderId'),
  );

  if (response.statusCode == 200) {
    return true; // Xóa thành công
  } else {
    print('Lỗi: ${response.body}');
    return false; // Xóa thất bại
  }
}

Future<bool> deleteOrderItem(String orderId) async {
  final response = await http.delete(
    Uri.parse('http://3.25.92.254:5000/api/orderitem/$orderId'),
  );

  if (response.statusCode == 200) {
    return true; // Xóa thành công
  } else {
    print('Lỗi: ${response.body}');
    return false; // Xóa thất bại
  }
}
