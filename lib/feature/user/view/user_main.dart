import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/login/view/login_main.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/auth_service.dart';

void main() {
  runApp(const ProfileMain());
}

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = AuthHelper.getUserEmail();

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.lightGray),
                      child: Center(
                        child: SvgPicture.asset(
                          'lib/assets/svg/navbar_icon_active/user.svg',
                          color: AppColor.normalGray,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (userName != 'none') ...[
                            Text(
                              'Xin chào, $userName',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Bạn đã là thành viên của TLegoWorld!',
                              style: TextStyle(
                                  fontSize: 12, color: AppColor.normalGray),
                            ),
                          ] else ...[
                            const FittedBox(
                              child: Text(
                                'Đăng nhập / Đăng ký',
                                style: TextStyle(
                                    color: AppColor.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              'Để có trải nghiệm tốt nhất',
                              style: TextStyle(
                                  fontSize: 12, color: AppColor.normalGray),
                            ),
                          ],
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Dash(
                direction: Axis.horizontal,
                length: 300,
                dashLength: 10,
                dashColor: AppColor.lightGray,
                dashThickness: 1,
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      titleTextStyle: const TextStyle(
                          fontSize: 14, color: AppColor.normalGray),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.person,
                        size: 20,
                        color: AppColor.mateGray,
                      ),
                      title: const Text('Thông tin cá nhân'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: AppColor.mateGray,
                      ),
                      onTap: () {
                        // Xử lý khi nhấn vào "Thông tin cá nhân"
                      },
                    ),
                    ListTile(
                      titleTextStyle: const TextStyle(
                          fontSize: 14, color: AppColor.normalGray),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.settings,
                        size: 20,
                        color: AppColor.mateGray,
                      ),
                      title: const Text('Cài đặt'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: AppColor.mateGray,
                      ),
                      onTap: () {
                        // Xử lý khi nhấn vào "Cài đặt"
                      },
                    ),
                    ListTile(
                      titleTextStyle: const TextStyle(
                          fontSize: 14, color: AppColor.normalGray),
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.info,
                        size: 20,
                        color: AppColor.mateGray,
                      ),
                      title: const Text('Giới thiệu'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: AppColor.mateGray,
                      ),
                      onTap: () {
                        // Xử lý khi nhấn vào "Giới thiệu"
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () async {
                    // ignore: use_build_context_synchronously
                    await AuthService().signOut()
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navbar()))
                        : "";
                  },
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: AppColor.primary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
