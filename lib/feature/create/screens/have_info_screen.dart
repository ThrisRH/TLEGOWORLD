// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/utils/format_phone_number.dart';

class HaveInfo extends StatefulWidget {
  final String cus_name;
  final String cus_phone;
  final String cus_address;
  final String cus_province;
  final String cus_district;
  final String cus_ward;
  const HaveInfo(
      {super.key,
      required this.cus_name,
      required this.cus_phone,
      required this.cus_address,
      required this.cus_province,
      required this.cus_district,
      required this.cus_ward});

  @override
  State<HaveInfo> createState() => _HaveInfoState();
}

class _HaveInfoState extends State<HaveInfo> {
  @override
  Widget build(BuildContext context) {
    final String fullAddress = widget.cus_address +
        ', ' +
        widget.cus_ward +
        ', ' +
        widget.cus_district +
        ', ' +
        widget.cus_province;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          widget.cus_name,
          style: const TextStyle(
              color: AppColor.mateGray,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        // PhoneNumber
        const SizedBox(
          height: 6,
        ),
        Text(
          formatPhoneNumber(widget.cus_phone),
          style: const TextStyle(
            color: AppColor.normalGray,
            fontSize: 14,
          ),
          textAlign: TextAlign.left,
        ),
        // Address
        const SizedBox(
          height: 6,
        ),
        Text(
          fullAddress,
          style: const TextStyle(
            color: AppColor.normalGray,
            fontSize: 14,
          ),
          textAlign: TextAlign.left,
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'Cập nhật thông tin',
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
