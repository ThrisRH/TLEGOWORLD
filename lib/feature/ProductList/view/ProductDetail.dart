import 'package:flutter/material.dart';
import 'package:tlego_world/components/button.dart';
import 'package:tlego_world/components/data_api/product_detail_data.dart';
import 'package:tlego_world/components/ListBar.dart';
import 'package:tlego_world/feature/ProductList/components/pro_description.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final String proID;

  const ProductDetailScreen({super.key, required this.proID});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map<String, dynamic>? productData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    try {
      List<Map<String, dynamic>> data = await fetchData(widget.proID);
      if (data.isNotEmpty) {
        setState(() {
          productData = data.first;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Không tìm thấy sản phẩm.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ListAppBar(title: ''),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 12, top: 12, right: 12, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          productData!['pro_img'],
                          height: 366,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(productData!['pro_name'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF0051BA))),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Căn 2 text về 2 phía
                        children: [
                          Text(
                            '${NumberFormat("#,###", "vi_VN").format(productData!['pro_price'])}đ',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFFE1001A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Đã bán ${productData!['sales_count']} đơn',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: RedButton(
                              onPressed: () => (),
                              text: 'MUA NGAY',
                            ),
                          ),
                          const SizedBox(width: 8),
                          ShoppingButton(
                            onPressed: () => (),
                          ),
                        ],
                      ),
                      if (productData != null)
                        ProductDescription(productData: productData!),
                    ],
                  ),
                ),
    );
  }
}
