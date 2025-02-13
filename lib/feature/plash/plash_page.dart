import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tlego_world/feature/home/app.dart';

class PlashPages extends StatelessWidget {
  const PlashPages({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,

        MaterialPageRoute(builder: (context) => const HomeMain()),
      );
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Chia không gian giữa các phần tử
        children: [
          // Khoảng trống phía trên
          const Spacer(),
          // Logo ở giữa màn hình
          Center(
            child: SvgPicture.asset(
              'lib/assets/png/app_logo.png',
            ),
          ),
          const SizedBox(height: 20),
          // Khoảng trống giữa logo và chữ
          const Spacer(),
          // Chữ nằm ở dưới cùng màn hình
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Text(
                  'Track Nest',
                  style: nameapp,
                ),
                Text(
                  'Nesting your savings for the future',
                  style: txtapp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle nameapp = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    fontFamily: 'HappyMonkey',
  );
  static const TextStyle txtapp = TextStyle(fontSize: 16, fontFamily: 'Lato');
}
