import 'package:flutter/material.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';
import 'package:tlego_world/feature/plash/plash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Tắt banner debug
      home: const PlashPages(),
    );
  }
}
