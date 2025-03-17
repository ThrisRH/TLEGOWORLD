// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';

class AppBarTitle extends StatefulWidget {
  final String title;
  const AppBarTitle({super.key, required this.title});

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColor.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const SizedBox(
          width: 32,
          height: 32,
        )
      ],
    );
  }
}
