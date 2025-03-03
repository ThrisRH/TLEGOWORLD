import 'package:flutter/material.dart';
import 'package:tlego_world/feature/home/components/item_cate.dart';
import 'package:tlego_world/feature/home/view/components/text_titlte.dart';
// Import component

void main() {
  runApp(const HomeMain());
}

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12), // Thêm padding 12px
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/png/homepage_png/banner.png',
                ),
                const SectionTitle(title: 'DANH MỤC TIÊU BIỂU'),
                const ImageGrid(
                  images: [
                    'lib/assets/png/homepage_png/city.png',
                    'lib/assets/png/homepage_png/Tech.png',
                    'lib/assets/png/homepage_png/nijja.png',
                    'lib/assets/png/homepage_png/creator.png',
                    'lib/assets/png/homepage_png/friend.png',
                    'lib/assets/png/homepage_png/disney.png',
                    'lib/assets/png/homepage_png/nijja.png',
                  ],
                  imagesPerRow: 4,
                ),
                const SectionTitle(title: 'SẢN PHẨM MỚI'),
                const ImageGrid(
                  images: [
                    'lib/assets/png/homepage_png/lego_conquay.png',
                    'lib/assets/png/homepage_png/lego_nija.png',
                    'lib/assets/png/homepage_png/lego_white.png',
                    'lib/assets/png/homepage_png/lego_xedua.png',
                    'lib/assets/png/homepage_png/lego_tech_black.png',
                    'lib/assets/png/homepage_png/lego_black.png',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
