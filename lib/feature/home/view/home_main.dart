import 'package:flutter/material.dart';

void main() {
  runApp(const HomeMain());
}

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(), // Trang trống
      ),
    );
  }
}
