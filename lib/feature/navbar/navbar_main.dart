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
      bottomNavigationBar: SizedBox(
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent, // Tắt hiệu ứng sóng nước
            highlightColor: Colors.transparent, // Tắt hiệu ứng sáng khi bấm
            hoverColor: Colors.transparent, // Tắt hiệu ứng hover
          ),
          child: BottomNavigationBar(
            enableFeedback: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 0 ? _selectedIcons[0] : _defaultIcons[0],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 1 ? _selectedIcons[1] : _defaultIcons[1],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 2 ? _selectedIcons[2] : _defaultIcons[2],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 3 ? _selectedIcons[3] : _defaultIcons[3],
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
