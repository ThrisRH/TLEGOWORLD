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
      categoriesList = categoriesData
          .map((category) => {
                "image": category["image"],
                "title": category["title"],
              })
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SearchBarbtn(onCartTap: () {}),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset('lib/assets/png/homepage_png/banner.png'),
                      const SectionTitle(title: 'DANH MỤC TIÊU BIỂU'),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ImageGrid(
                              images: categoriesList
                                  .map((category) =>
                                      category['image']?.toString() ?? '')
                                  .toList(),
                              imagesPerRow: 5,
                              onImageTap: (String imagePath) {},
                              title: categoriesList
                                  .map((category) =>
                                      category['title']?.toString() ?? '')
                                  .toList(),
                            ),
                      const SectionTitle(title: 'SẢN PHẨM MỚI'),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ImageGrid(
                              images: categoriesList
                                  .map((category) =>
                                      category['image']?.toString() ?? '')
                                  .toList(),
                              imagesPerRow: 5,
                              onImageTap: (String imagePath) {},
                              title: categoriesList
                                  .map((category) =>
                                      category['title']?.toString() ?? '')
                                  .toList(),
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
