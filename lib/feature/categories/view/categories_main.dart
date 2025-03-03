import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/categories/components/item.dart';

void main() {
  runApp(const CategoriesMain());
}

// Danh sách danh mục mẫu
final List<Map<String, dynamic>> categories = [
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
  {
    "image": "lib/assets/images/ninjago_cate.png",
    "title": "LEGO City",
    "count": 120,
  },
];

class CategoriesMain extends StatelessWidget {
  const CategoriesMain({super.key});

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
                // search bar
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Expanded(
                          flex: 4,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              prefixIcon: Container(
                                width: 32,
                                height: 32,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primary,
                                ),
                                child: const Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: AppColor.primary,
                              ),
                              hintText: 'Tìm kiếm sản phẩm bạn quan tâm',
                              hintStyle:
                                  const TextStyle(color: AppColor.normalGray),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 241, 241, 241),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12), // Khoảng cách giữa 2 phần
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Color(0xFF28282B),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    shrinkWrap: true, // Để GridView không chiếm hết không gian
                    physics:
                        NeverScrollableScrollPhysics(), // Tắt cuộn trong GridView
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cột
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio:
                          0.8, // Tỉ lệ chiều rộng/chiều cao của mỗi item
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryCard(
                        imageUrl: category['image'],
                        title: category['title'],
                        itemCount: category['count'],
                        onTap: () {
                          print("Chọn danh mục: ${category['title']}");
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
