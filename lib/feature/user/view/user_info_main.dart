// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/assets/style/text.dart';
import 'package:tlego_world/components/app_bar.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/auth_service.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  late Future<dynamic> _userFuture;

  @override
  void initState() {
    super.initState();
    String userId = AuthHelper.getUserId();
    _userFuture = AuthService.getUserInfo(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: AppColor.lightGray.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ]),
          child: const AppBarTitle(title: 'THÔNG TIN'),
        ),
      ),
      body: FutureBuilder(
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

            final userInfo = snapshot.data!;

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                children: [
                  // Họ tên
                  Row(
                    children: [
                      const Text(
                        'Họ và tên',
                        style: normalTextStyle,
                      ),
                      const Spacer(),
                      Text(userInfo['cus_name'], style: normalTextStyle)
                    ],
                  ),
                  // Gmail
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Gmail',
                        style: normalTextStyle,
                      ),
                      const Spacer(),
                      Text(userInfo['cus_email'], style: normalTextStyle)
                    ],
                  ),
                  // Số điện thoại
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Số điện thoại',
                        style: normalTextStyle,
                      ),
                      const Spacer(),
                      Text(userInfo['cus_phone'], style: normalTextStyle)
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  // Địa chỉ
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Địa chỉ',
                        style: normalTextStyle,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Flexible(
                        child: Text(
                          userInfo['cus_address'],
                          style: normalTextStyle,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          maxLines: 4,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
