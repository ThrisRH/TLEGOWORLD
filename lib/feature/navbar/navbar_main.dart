import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tlego_world/feature/categories/app.dart';
import 'package:tlego_world/feature/home/app.dart';
import 'package:tlego_world/feature/order/app.dart';
import 'package:tlego_world/feature/nofi/app.dart';

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
    const NofiMain(),
  ];

  final List<String> _selectedIcons = [
    'lib/assets/svg/navbar_icon_active/home_icon.svg',
    'lib/assets/svg/navbar_icon_active/cate_icon.svg',
    'lib/assets/svg/navbar_icon_active/order_icon.svg',
    'lib/assets/svg/navbar_icon_active/nofi_icon.svg',
  ];

  final List<String> _defaultIcons = [
    'lib/assets/svg/navbar_icon_inactive/home_icon.svg',
    'lib/assets/svg/navbar_icon_inactive/cate_icon.svg',
    'lib/assets/svg/navbar_icon_inactive/order_icon.svg',
    'lib/assets/svg/navbar_icon_inactive/nofi_icon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor:
            Colors.white, // ✅ Đổi màu navbar thành màu xanh (hoặc màu bạn muốn)
        selectedItemColor: Colors.white, // ✅ Màu của icon khi được chọn
        unselectedItemColor: Colors.grey, // ✅ Màu của icon chưa chọn
        type: BottomNavigationBarType
            .fixed, // ✅ Giữ icon tĩnh, không bị co giãn khi chọn
        items: List.generate(4, (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == index
                  ? _selectedIcons[index]
                  : _defaultIcons[index],
            ),
            label: '',
          );
        }),
      ),
    );
  }
}
