Future<String> generateVietQR(double amount, String description) async {
  const String bankId = "970436"; // Thay bằng mã ngân hàng của bạn
  const String template = "print"; // Mẫu VietQR, có thể thay đổi nếu cần
  const String accountName = "NGUYEN DUC TRI"; // Thay bằng tên tài khoản
  const String accountNo = '1041849903';
  // Tạo URL VietQR
  final String qrUrl =
      "https://img.vietqr.io/image/$bankId-$accountNo-$template.png?amount=$amount&addInfo=${Uri.encodeComponent(description)}&accountName=${Uri.encodeComponent(accountName)}";

  return qrUrl;
}
