import 'package:flutter/material.dart';
import 'package:tlego_world/feature/plash/plash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlashPages(),
    );
  }
}
