import 'package:flutter/material.dart';
import 'package:tlego_world/components/data_api/categories_data.dart';
import 'package:tlego_world/components/component/search.dart';
import 'package:tlego_world/components/data_api/product/product_all_api.dart';
import 'package:tlego_world/feature/ProductList/view/ProductDetail.dart';
import 'package:tlego_world/feature/ProductList/view/ProductList_main.dart';
import 'package:tlego_world/feature/home/components/item_cate.dart';
import 'package:tlego_world/feature/home/view/components/text_titlte.dart';
import 'package:tlego_world/feature/payment/payments.dart';

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
  List<Map<String, dynamic>> productList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// Load dữ liệu từ API
  Future<void> loadData() async {
    try {
      final results = await Future.wait([
        FetchCategories.fetchData(),
        fetchDataProductall(),
      ]);

      if (!mounted) return; // Kiểm tra widget có còn tồn tại

      setState(() {
        categoriesList = results[0]
            .map((category) => {
                  "image": category["image"],
                  "title": category["title"],
                  "count": category["count"],
                  "cate": category["cate"],
                })
            .toList();

        productList = results[1]
            .map((pro) => {
                  "pro_img": pro["pro_img"],
                  "pro_name": pro["pro_name"],
                  "pro_ID": pro["pro_ID"],
                })
            .toList();

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print("Lỗi tải dữ liệu: $e");
    }
  }

  /// Điều hướng đến danh mục sản phẩm
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

  /// Điều hướng đến chi tiết sản phẩm
  void navigateToDetail(BuildContext context, String proID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(proID: proID),
      ),
    );
  }

  /// Điều hướng đến trang thanh toán
  void navigateTo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyAppTest(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SearchBarbtn(onCartTap: () {}),
                    const SizedBox(height: 30),
                    Image.asset('lib/assets/png/homepage_png/banner.png'),
                    const SectionTitle(title: 'DANH MỤC TIÊU BIỂU'),
                    ImageGrid(
                      images: categoriesList
                          .map(
                              (category) => category['image']?.toString() ?? '')
                          .toList(),
                      imagesPerRow: 5,
                      onImageTap: (String imagePath) {},
                      title: categoriesList
                          .map(
                              (category) => category['title']?.toString() ?? '')
                          .toList(),
                      onTap: (index) {
                        final category = categoriesList[index];
                        navigateToCategoryDetail(
                          context,
                          category['title']?.toString() ?? '',
                          category['cate']?.toString() ?? '',
                          category['count'] is int
                              ? category['count']
                              : (category['count'] != null
                                  ? int.tryParse(
                                          category['count'].toString()) ??
                                      0
                                  : 0),
                        );
                      },
                    ),
                    const SectionTitle(title: 'SẢN PHẨM MỚI'),
                    ImageGrid(
                      images: productList
                          .map((pro) => pro['pro_img']?.toString() ?? '')
                          .toList(),
                      imagesPerRow: 4,
                      spacing: 16,
                      onImageTap: (String imagePath) {},
                      title: productList
                          .map((pro) => pro['pro_name']?.toString() ?? '')
                          .toList(),
                      onTap: (int index) {
                        final product = productList[index];
                        navigateToDetail(
                          context,
                          product['pro_ID']?.toString() ?? '',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Loading Indicator ở giữa màn hình
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color:
                      Colors.white.withOpacity(0.8), // Làm mờ nền khi loading
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
