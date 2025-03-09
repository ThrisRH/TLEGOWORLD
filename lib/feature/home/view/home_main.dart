import 'package:flutter/material.dart';
import 'package:tlego_world/components/data_api/categories_data.dart';
import 'package:tlego_world/components/search.dart';
import 'package:tlego_world/feature/home/components/item_cate.dart';
import 'package:tlego_world/feature/home/view/components/text_titlte.dart';

void main() {
  runApp(const HomeMain());
}

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  List<Map<String, dynamic>> categoriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categoriesData = await FetchCategories.fetchData();
    setState(() {
      // Chỉ lấy danh sách ảnh
      categoriesList = categoriesData
          .map((category) => {"image": category["image"]})
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SearchBarbtn(onCartTap: () {}),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Image.asset('lib/assets/png/homepage_png/banner.png'),
                      const SectionTitle(title: 'DANH MỤC TIÊU BIỂU'),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ImageGrid(
                              images: categoriesList
                                  .map((category) => category['image'])
                                  .toList(), // ✅ Chỉ lấy danh sách ảnh
                              imagesPerRow: 5,
                              onImageTap: (String imagePath) {},
                            ),
                      const SectionTitle(title: 'SẢN PHẨM MỚI'),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ImageGrid(
                              images: categoriesList
                                  .map((category) => category['image'])
                                  .toList(), // ✅ Chỉ lấy danh sách ảnh
                              imagesPerRow: 5,
                              onImageTap: (String imagePath) {},
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
