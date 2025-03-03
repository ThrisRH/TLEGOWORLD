import 'package:flutter/material.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';

class PlashPages extends StatefulWidget {
  const PlashPages({super.key});

  @override
  State<PlashPages> createState() => _PlashPagesState();
}

class _PlashPagesState extends State<PlashPages> {
  @override
  void initState() {
    super.initState();
    // Sau 3 giây, chuyển sang Navbar
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Navbar(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/png/app_logo.png', // Đường dẫn đúng tới file PNG
        ),
      ),
    );
  }
}
