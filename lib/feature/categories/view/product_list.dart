import 'package:flutter/material.dart';

void main() {
  runApp(const ProductList(imagePath: ''));
}

// Component hiển thị từng sản phẩm
class ProductItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String sold;

  const ProductItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.sold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // Padding bên trong
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2), // Viền đỏ
        borderRadius: BorderRadius.circular(12), // Bo góc nhẹ
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0051BA),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sold,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Màn hình danh sách sản phẩm
class ProductList extends StatelessWidget {
  const ProductList({super.key, required String imagePath});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> products = [
      {
        "imagePath": "lib/assets/png/homepage_png/list_lego.png",
        "title": "Đồ chơi lắp ráp chiến giáp của Arin Lego Ninjago 71804",
        "price": "449.000đ",
        "sold": "Đã bán 1,5k đơn",
      },
      {
        "imagePath": "lib/assets/png/homepage_png/list_lego.png",
        "title": "Bộ lắp ráp mô hình Lego City cảnh sát 60316",
        "price": "529.000đ",
        "sold": "Đã bán 2k đơn",
      },
      {
        "imagePath": "lib/assets/png/homepage_png/list_lego.png",
        "title": "Lego Creator Expert Ford Mustang 10265",
        "price": "3.290.000đ",
        "sold": "Đã bán 500 đơn",
      },
      {
        "imagePath": "lib/assets/png/homepage_png/list_lego.png",
        "title": "Bộ lắp ráp Lego Star Wars Millennium Falcon 75192",
        "price": "15.990.000đ",
        "sold": "Đã bán 100 đơn",
      }
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 sản phẩm trên 1 dòng
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7, // Tỷ lệ giữa chiều rộng và chiều cao
            ),
            itemBuilder: (context, index) {
              return ProductItem(
                imagePath: products[index]["imagePath"]!,
                title: products[index]["title"]!,
                price: products[index]["price"]!,
                sold: products[index]["sold"]!,
              );
            },
          ),
        ),
      ),
    );
  }
}
