// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/app_bar.dart';
import 'package:tlego_world/feature/create/create_order.dart';
import 'package:tlego_world/feature/home/app.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';
import 'package:tlego_world/model/product.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/cart_service.dart';
import 'package:tlego_world/utils/format_currency.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<dynamic>> _cartFuture;
  double totalPrice = 0;
  double totalProduct = 0;
  @override
  void initState() {
    super.initState();
    String userId = AuthHelper.getUserId();
    print(userId);
    _cartFuture = CartService.getUserCart(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: AppColor.lightGray.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]),
          child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: AppBarTitle(title: 'GIỎ HÀNG CỦA BẠN')),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: FutureBuilder<List<dynamic>>(
                future: _cartFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Lỗi: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return NoProInCart();
                  }

                  final carts = snapshot.data!;

                  /// Total
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    double newTotal = carts.fold(0, (sum, item) {
                      final price =
                          double.tryParse(item["pro_price"].toString()) ?? 0;
                      final quantity = item["pro_quantity"] ?? 1;
                      return sum + (price * quantity);
                    });

                    if (totalPrice != newTotal) {
                      setState(() {
                        totalPrice = newTotal;
                      });
                    }
                  });

                  /// Quantity
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    double newTotal = carts.fold(0, (sum, item) {
                      final quantity =
                          double.tryParse(item["pro_quantity"].toString()) ?? 0;
                      return sum + quantity;
                    });

                    if (totalProduct != newTotal) {
                      setState(() {
                        totalProduct = newTotal;
                      });
                    }
                  });

                  print("Tổng tiền giỏ hàng: $totalPrice");

                  return ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      final item = carts[index];
                      // print('SP: ${item['pro_name']}');

                      return Container(
                        margin: EdgeInsets.only(bottom: 24),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Hình ảnh sản phẩm
                              Image.network(
                                item['pro_img'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 12),

                              /// Phần chứa tên, giá và số lượng
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Tên sản phẩm + nút xóa
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Tên sản phẩm
                                        Expanded(
                                          child: Text(
                                            '${item['pro_name']}',
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 6,
                                            softWrap: true,
                                          ),
                                        ),
                                        Spacer(),

                                        /// Nút xóa
                                        GestureDetector(
                                          onTap: () {},
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: SvgPicture.asset(
                                              'lib/assets/svg/trash_bin.svg',
                                              width: 24, // Định rõ kích thước
                                              height: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 12),

                                    /// **Giá và số lượng nằm cùng hàng**
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        /// **Giá tiền**
                                        FittedBox(
                                          child: Text(
                                            '${formatCurrency(item['pro_price'].toInt())}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: AppColor.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        /// **Số lượng**
                                        Row(
                                          children: [
                                            /// Nút giảm
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (item['pro_quantity'] >
                                                      1) {
                                                    item['pro_quantity'] -= 1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          item['pro_quantity'] == 1
                                                              ? AppColor
                                                                  .lightGray
                                                              : AppColor
                                                                  .mateGray),
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  color:
                                                      item['pro_quantity'] == 1
                                                          ? AppColor.lightGray
                                                          : AppColor.mateGray,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),

                                            /// Ô số lượng
                                            Container(
                                              width: 48,
                                              height: 24,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    color: AppColor.mateGray),
                                              ),
                                              child: Text(
                                                '${item['pro_quantity']}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),

                                            /// Nút tăng
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (item['pro_quantity'] <
                                                      10) {
                                                    item['pro_quantity'] += 1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          item['pro_quantity'] ==
                                                                  10
                                                              ? AppColor
                                                                  .lightGray
                                                              : AppColor
                                                                  .mateGray),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color:
                                                      item['pro_quantity'] == 10
                                                          ? AppColor.lightGray
                                                          : AppColor.mateGray,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          OrderButton(totalPrice: totalPrice, totalProduct: totalProduct)
        ],
      ),
    );
  }
}

class NoProInCart extends StatelessWidget {
  const NoProInCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset('lib/assets/images/lego_pics/empty_cart.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Bạn chưa có sản phẩm nào trong giỏ hàng !',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.mateGray)),
              SizedBox(
                height: 6,
              ),
              Text('Hãy lựa chọn và thêm sản phẩm vào giỏ hàng.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.normalGray,
                  )),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Navbar()));
            },
            child: Text('Bắt đầu mua sắm',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.primaryBlue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primaryBlue,
                    decorationThickness: 1,
                    height: 1)),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final double totalProduct;
  final double totalPrice;

  const OrderButton(
      {super.key, required this.totalPrice, required this.totalProduct});

  @override
  State<OrderButton> createState() => OrderButtonState();
}

class OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 0, bottom: 12, left: 24, right: 24),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: AppColor.primary, width: 1), // Border cạnh trái
                right: BorderSide(
                    color: AppColor.primary, width: 1), // Border cạnh phải
                top: BorderSide(color: AppColor.primary, width: 1),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      'Tổng giá trị (${widget.totalProduct.toInt()}):',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.mateGray,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${formatCurrency(widget.totalPrice.toInt())}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: AppColor.primary, width: 1), // Border cạnh trái
                  right: BorderSide(
                      color: AppColor.primary, width: 1), // Border cạnh phải
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Container(
                  alignment: Alignment.center,
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(24)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentChecking()));
                    },
                    child: Text(
                      'ĐẶT HÀNG NGAY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
