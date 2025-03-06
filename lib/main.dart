import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';
import 'package:tlego_world/feature/plash/plash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Đã kết nối Firebase');
  } catch (e) {
    print('Lỗi kết nối FB');
  }
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
