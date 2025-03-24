import 'package:flutter/material.dart';
import 'package:tlego_world/components/component/button.dart';
import 'package:tlego_world/feature/create/components/vietqr.dart';
import 'package:tlego_world/feature/create/create_order.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';

class OnlinePaymentScreen extends StatefulWidget {
  final double totalAll;
  final String id;

  const OnlinePaymentScreen(
      {super.key, required this.totalAll, required this.id});

  @override
  _OnlinePaymentScreenState createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  String qrData = '';

  @override
  void initState() {
    super.initState();
    _generateQR();
  }

  Future<void> _generateQR() async {
    String qrUrl = await generateVietQR(widget.totalAll, widget.id);
    setState(() {
      qrData = qrUrl;
    });
  }

  void _confirmPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Navbar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: const Text("Thanh toán trực tuyến")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: qrData.isNotEmpty
                  ? Image.network(qrData)
                  : const CircularProgressIndicator(),
            ),
            const Spacer(),
            RedButton(
              onPressed: _confirmPayment,
              text: 'Đã chuyển khoản',
            ),
          ],
        ),
      ),
    );
  }
}
