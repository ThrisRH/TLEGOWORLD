import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';

class NoInfo extends StatelessWidget {
  const NoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'lib/assets/images/lego_pics/no_info.png',
            width: 138,
            height: 138,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Text(
          'Bạn chưa có thông tin nhận hàng!',
          style: TextStyle(color: AppColor.mateGray),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 6,
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'Cập nhật ngay',
            style: TextStyle(
                color: AppColor.primaryBlue,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.primaryBlue),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
