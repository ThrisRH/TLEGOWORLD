import 'package:flutter/material.dart';
import 'package:tlego_world/feature/categories/components/item_cate.dart';
import 'package:tlego_world/feature/categories/view/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn banner debug
      home: const CategoriesMain(),
    );
  }
}

class CategoriesMain extends StatelessWidget {
  const CategoriesMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12), // Thêm padding 12px
          child: Column(
            children: [
              ImageGrid(
                images: const [
                  'lib/assets/png/homepage_png/city.png',
                  'lib/assets/png/homepage_png/Tech.png',
                  'lib/assets/png/homepage_png/nijja.png',
                  'lib/assets/png/homepage_png/creator.png',
                  'lib/assets/png/homepage_png/friend.png',
                  'lib/assets/png/homepage_png/disney.png',
                  'lib/assets/png/homepage_png/nijja.png',
                  'lib/assets/png/homepage_png/lego_conquay.png',
                  'lib/assets/png/homepage_png/lego_nija.png',
                  'lib/assets/png/homepage_png/lego_white.png',
                  'lib/assets/png/homepage_png/lego_xedua.png',
                  'lib/assets/png/homepage_png/lego_tech_black.png',
                  'lib/assets/png/homepage_png/lego_black.png',
                ],
                onImageTap: (imagePath) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductList(imagePath: imagePath),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
