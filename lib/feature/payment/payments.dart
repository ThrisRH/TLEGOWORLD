import 'package:flutter/material.dart';

class MyAppTest extends StatelessWidget {
  const MyAppTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Trang Đơn Giản')),
        body: const Center(
          child: Text(
            'Xin chào! Đây là một trang đơn giản.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
