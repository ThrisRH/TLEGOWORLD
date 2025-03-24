import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/categories/app.dart';
import 'package:tlego_world/feature/home/app.dart';
import 'package:tlego_world/feature/order/app.dart';
import 'package:tlego_world/feature/user/app.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _MainPageState();
}

class _MainPageState extends State<Navbar> {
  int _currentIndex = 0;

  // Danh sách các trang con
  final List<Widget> _pages = [
    const HomeMain(),
    const CategoriesMain(),
    const OrderMain(),
    const ProfileMain(),
  ];

  final List<String> _tabIcons = [
    'lib/assets/svg/navbar_icon_active/home_icon.svg',
    'lib/assets/svg/navbar_icon_active/cate_icon.svg',
    'lib/assets/svg/navbar_icon_active/order_icon.svg',
    'lib/assets/svg/navbar_icon_active/nofi_icon.svg',
  ];
  final List<String> _tabTitle = [
    'Trang chủ',
    'Danh mục',
    'Đơn hàng',
    'Cá nhân',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 64,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors
              .white, // ✅ Đổi màu navbar thành màu xanh (hoặc màu bạn muốn)
          selectedItemColor: AppColor.primary, // ✅ Màu của icon khi được chọn
          unselectedItemColor: AppColor.normalGray, // ✅ Màu của icon chưa chọn
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          selectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          type: BottomNavigationBarType
              .fixed, // ✅ Giữ icon tĩnh, không bị co giãn khi chọn
          items: List.generate(4, (index) {
            return BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    _tabIcons[index],
                    color: _currentIndex == index
                        ? AppColor.primary
                        : AppColor.normalGray,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
              label: _tabTitle[index],
            );
          }),
        ),
      ),
    );
  }
}
