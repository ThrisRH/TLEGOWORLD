// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/box_info.dart';
import 'package:tlego_world/feature/create/screens/have_info_screen.dart';
import 'package:tlego_world/feature/create/screens/no_info_screen.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/auth_service.dart';

class UserInfoBox extends StatefulWidget {
  const UserInfoBox({super.key});

  @override
  State<UserInfoBox> createState() => _UserInfoBoxState();
}

class _UserInfoBoxState extends State<UserInfoBox> {
  late Future<dynamic> _userFuture;

  @override
  void initState() {
    super.initState();
    String userId = AuthHelper.getUserId();
    // print('User ID: $userId');
    _userFuture = AuthService.getUserInfo(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BoxInfo(
      title: 'Thông tin người mua',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGray),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4))),
        child: FutureBuilder<dynamic>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator()); // Đang tải dữ liệu
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Lỗi: ${snapshot.error}")); // Báo lỗi nếu có
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("Không có dữ liệu")); // Không có dữ liệu hợp lệ
              }

              @override
              final userInfo = snapshot.data!;

              return (userInfo['cus_address'] == "" ||
                      userInfo['cus_name'] == "" ||
                      userInfo['cus_phone'] == "" ||
                      userInfo['cus_email'] == "" ||
                      userInfo['cus_id'] == "" ||
                      userInfo['cus_province'] == "" ||
                      userInfo['cus_district'] == "" ||
                      userInfo['cus_ward'] == "")
                  ? const NoInfo()
                  : HaveInfo(
                      cus_name: userInfo['cus_name'],
                      cus_phone: userInfo['cus_phone'],
                      cus_address: userInfo['cus_address'],
                      cus_province: userInfo['cus_province'],
                      cus_district: userInfo['cus_district'],
                      cus_ward: userInfo['cus_ward'],
                    );
            }),
      ),
    );
  }
}

class UserNoAccoutInfo extends StatefulWidget {
  final String guestName;
  final String guestPhone;
  final String guestAddress;
  final String province;
  final String district;
  final String ward;
  const UserNoAccoutInfo(
      {super.key,
      required this.guestName,
      required this.guestPhone,
      required this.guestAddress,
      required this.province,
      required this.district,
      required this.ward});

  @override
  State<UserNoAccoutInfo> createState() => _UserNoAccoutInfoState();
}

class _UserNoAccoutInfoState extends State<UserNoAccoutInfo> {
  @override
  Widget build(BuildContext context) {
    return BoxInfo(
        title: 'Thông tin người mua',
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.lightGray),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4))),
            child: HaveInfo(
              cus_name: widget.guestName,
              cus_phone: widget.guestPhone,
              cus_address: widget.guestAddress,
              cus_province: widget.province,
              cus_district: widget.district,
              cus_ward: widget.ward,
            )));
  }
}
