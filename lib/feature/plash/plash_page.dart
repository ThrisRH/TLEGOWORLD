import 'package:flutter/material.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';

class PlashPages extends StatelessWidget {
  const PlashPages({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Navbar()),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/png/app_logo.png', // Đường dẫn đúng tới file PNG
        ),
      ),
    );
  }
}
