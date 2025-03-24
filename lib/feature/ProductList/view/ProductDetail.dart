// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tlego_world/components/component/QuantitySelector.dart';
import 'package:tlego_world/components/component/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/data_api/product_detail_data.dart';
import 'package:tlego_world/components/component/ListBar.dart';
import 'package:tlego_world/feature/ProductList/components/add_product_popup.dart';
import 'package:tlego_world/feature/ProductList/components/pro_description.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/feature/create/checkout_buynow.dart';
import 'package:tlego_world/feature/create/unlog_views/unlogin_info.dart';
import 'package:tlego_world/feature/login/view/login_main.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/auth_service.dart';
import 'package:tlego_world/services/cart_service.dart';
import 'package:tlego_world/services/rating_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final String proID;

  const ProductDetailScreen({super.key, required this.proID});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map<String, dynamic>? productData;
  List<Map<String, dynamic>> reviews = [];
  bool isLoading = true;
  String errorMessage = '';
  String userId = "";

  @override
  void initState() {
    super.initState();
    userId = AuthHelper.getUserId();
    fetchProductData();
    getReviews(widget.proID);
  }

  void getReviews(String proID) async {
    List<Map<String, dynamic>>? fetchedReviews =
        await RatingService.fetchReviews(proID);

    if (fetchedReviews != null) {
      setState(() {
        reviews = fetchedReviews.reversed.take(3).toList();
      });
    } else {
      print("Không tìm thấy đánh giá.");
    }
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

  void _showCartNowPopup() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return BuyNowPopup(
          productName: productData!['pro_name'],
          productImage: productData!['pro_img'],
          productPrice: productData!['pro_price'],
          onConfirm: (QuantitySelector) async {
            bool success = await CartService.addUserCart(userId, widget.proID);
            String? uid = AuthHelper.getUserId();

            if (uid == null || uid.isEmpty || uid == "none") {
              print('this');
              _showLoginPopup();
              return;
            }
            print('uid: $uid');
            if (success) {
              Fluttertoast.showToast(
                  msg: 'Thêm thành công',
                  backgroundColor: AppColor.normalGray.withOpacity(0.3));
            } else {
              Fluttertoast.showToast(msg: 'Thất bại');
            }
            Navigator.pop(context);
            // Thực hiện hành động mua hàng
          },
          isCart: true,
        );
      },
    );
  }

  void _showBuyNowPopup() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return BuyNowPopup(
          productName: productData!['pro_name'],
          productImage: productData!['pro_img'],
          productPrice: productData!['pro_price'],
          onConfirm: (quantity) async {
            // print("Số lượng được chọn: $quantity");
            print('check: ${userId.isEmpty}');
            if (userId != null &&
                userId.trim().isNotEmpty &&
                userId != "none") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UnloginInfo(
                    proID: widget.proID,
                    proQuantity: quantity,
                  ),
                ),
              );
            } else {
              final userData = await AuthService.getUserInfo(userId);
              print('thís');
              if (userData == null) {
                return;
              } else {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutBuyNow(
                      proID: widget.proID,
                      proQuantity: quantity,
                      guestPhone:
                          userData["cus_phone"] ?? "", // Sửa lỗi tại đây
                      guestName: userData["cus_name"] ?? "",
                      guestAddress: userData["cus_address"] ?? "",
                      province: userData["cus_province"] ?? "",
                      district: userData["cus_district"] ?? "",
                      ward: userData["cus_ward"] ?? "",
                    ),
                  ),
                );
              }
            }
          },
          isCart: false,
        );
      },
    );
  }

  void _showLoginPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Bạn chưa đăng nhập"),
        content: const Text("Vui lòng đăng nhập để tiếp tục."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Đóng"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage())); // Điều hướng đến trang đăng nhập
            },
            child: Text("Đăng nhập"),
          ),
        ],
      ),
    );
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
                              onPressed: _showBuyNowPopup,
                              text: 'MUA NGAY',
                            ),
                          ),
                          const SizedBox(width: 8),
                          ShoppingButton(
                            onPressed: _showCartNowPopup,
                          ),
                        ],
                      ),
                      if (productData != null)
                        ProductDescription(productData: productData!),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Đánh giá khách hàng',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF1C1C1C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      reviews.isEmpty
                          ? const Center(child: Text("Chưa có đánh giá nào"))
                          : Column(
                              children: reviews.map((review) {
                                return Card(
                                  color: Colors.white, // Nền trắng
                                  elevation: 0, // Không shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8), // Bo góc nhẹ
                                    side: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1), // Viền 1px màu xám nhạt
                                  ),
                                  child: ListTile(
                                    leading: const Icon(Icons.verified_user,
                                        color: AppColor.trueColor),
                                    title: Text("⭐ ${review['order_rating']}"),
                                    subtitle: Text(review['order_review']),
                                  ),
                                );
                              }).toList(),
                            )
                    ],
                  ),
                ),
    );
  }
}
