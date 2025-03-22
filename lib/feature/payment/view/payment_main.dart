import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VnPayQR extends StatelessWidget {
  final String vnpayUrl;
  final int amount; // Số tiền

  VnPayQR({required this.vnpayUrl, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán VNPay"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo VNPay QR

          const SizedBox(height: 10),

          // Hiển thị số tiền
          Text(
            "${amount.toStringAsFixed(0)} VND",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          // Mã QR
          QrImageView(
            data: vnpayUrl,
            version: QrVersions.auto,
            size: 250.0,
          ),
          const SizedBox(height: 10),

          // Nút tải mã thanh toán
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Xử lý tải mã QR về máy
            },
            icon: const Icon(Icons.download),
            label: const Text("Tải mã thanh toán"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
