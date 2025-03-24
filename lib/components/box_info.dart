import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';

class BoxInfo extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget? child;
  const BoxInfo({super.key, required this.title, this.subtitle, this.child});

  @override
  State<BoxInfo> createState() => _BoxInfoState();
}

class _BoxInfoState extends State<BoxInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.lightGray),
                left: BorderSide(color: AppColor.lightGray),
                right: BorderSide(color: AppColor.lightGray),
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4))),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.normalGray),
              ),
              const Spacer(),
              Text(widget.subtitle ?? ''),
            ],
          ),
        ),
        Container(
          child: widget.child,
        )
      ],
    );
  }
}
