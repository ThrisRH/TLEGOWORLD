import 'package:flutter/material.dart';
import 'package:tlego_world/components/search.dart';
import 'package:tlego_world/feature/ProductList/view/ProductList_main.dart';
import 'package:tlego_world/feature/categories/components/item.dart';
import 'package:tlego_world/components/data_api/categories_data.dart';

void main() {
  runApp(const CategoriesMain());
}

class CategoriesMain extends StatefulWidget {
  const CategoriesMain({super.key});

  @override
  _CategoriesMainState createState() => _CategoriesMainState();
}

class _CategoriesMainState extends State<CategoriesMain> {
  List<Map<String, dynamic>> categoriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final data = await FetchCategories.fetchData();
    setState(() {
      categoriesList = data;
      isLoading = false;
    });
  }

  void navigateToCategoryDetail(BuildContext context, String categoryTitle,
      String cate, int categoryCount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListScreen(
          title: categoryTitle,
          cate: cate,
          count: categoryCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: Column(
              children: [
                SearchBarbtn(
                  onCartTap: () {},
                ),
                const SizedBox(height: 24),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : categoriesList.isEmpty
                        ? const Center(child: Text("Không có danh mục nào"))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: categoriesList.length,
                              itemBuilder: (context, index) {
                                final category = categoriesList[index];
                                return CategoryCard(
                                  imageUrl: category['image'],
                                  title: category['title'],
                                  itemCount: category['count'],
                                  onTap: () {
                                    navigateToCategoryDetail(
                                      context,
                                      category['title'],
                                      category['cate'],
                                      category['count'] is int
                                          ? category['count']
                                          : int.parse(
                                              category['count'].toString()),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
