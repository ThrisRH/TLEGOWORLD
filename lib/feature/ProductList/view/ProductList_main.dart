import 'package:flutter/material.dart';
import 'package:tlego_world/components/data_api/product_data.dart';
import 'package:tlego_world/components/component/ListBar.dart';
import 'package:tlego_world/feature/ProductList/components/product_cart.dart';

class ProductListScreen extends StatefulWidget {
  final String title;
  final int count;
  final String cate;

  const ProductListScreen(
      {super.key,
      required this.title,
      required this.count,
      required this.cate});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Map<String, dynamic>>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchData(widget.cate); // Truyền title vào API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ListAppBar(title: widget.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                '${widget.count} sản phẩm',
                style: const TextStyle(fontSize: 14, color: Color(0xFF808080)),
              ),
            ),
            const SizedBox(height: 15),

            // Hiển thị danh sách sản phẩm từ API
            FutureBuilder<List<Map<String, dynamic>>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm nào.'));
                }

                final products = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 sản phẩm mỗi hàng
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product['pro_img'],
                      title: product['pro_name'],
                      price: product['pro_price'],
                      sold: product['sales_count'],
                      proID: product['pro_ID'],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
