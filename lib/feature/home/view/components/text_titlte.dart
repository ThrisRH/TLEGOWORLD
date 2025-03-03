import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            endIndent: 8, // Khoảng cách với chữ
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 12), // Tạo khoảng cách ngang
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            indent: 8, // Khoảng cách với chữ
          ),
        ),
      ],
    );
  }
}
