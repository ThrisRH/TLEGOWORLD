// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/home/app.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';
import 'package:tlego_world/model/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> products = [
    Product(
        name: 'Đồ chơi lắp ráp chiến giáp của arin lego ninjago 71804',
        image: 'lib/assets/images/products/pro1.png',
        quantity: 2,
        price: 449000),
    Product(
        name: 'Đồ chơi lắp ráp Hoa thủy tiên LEGO® LEGO BOTANICALS 40747',
        image: 'lib/assets/images/products/pro2.png',
        quantity: 1,
        price: 449000),
  ];

  String formatCurrency(int amount) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: const [
            BoxShadow(
              color: AppColor.lightGray,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'GIỎ HÀNG CỦA BẠN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(
                  width: 32,
                  height: 32,
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Hình ảnh sản phẩm
                          Image.asset(
                            product.image,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Tên sản phẩm
                                    Expanded(
                                      child: Text(
                                        product.name,
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
                                        '${formatCurrency(product.price.toInt())}',
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
                                              if (product.quantity > 1) {
                                                product.quantity -= 1;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: product.quantity == 1
                                                      ? AppColor.lightGray
                                                      : AppColor.mateGray),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: product.quantity == 1
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
                                            '${product.quantity}',
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
                                              if (product.quantity < 10) {
                                                product.quantity += 1;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: product.quantity == 10
                                                      ? AppColor.lightGray
                                                      : AppColor.mateGray),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: product.quantity == 10
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
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: AppColor.primary,
                          width: 1), // Border cạnh trái
                      right: BorderSide(
                          color: AppColor.primary,
                          width: 1), // Border cạnh phải
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
                            'Tổng giá trị (${products.fold(0, (sum, product) => sum + product.quantity)}):',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.mateGray,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${formatCurrency(products.fold(0, (sum, product) => sum + product.price.toInt() * product.quantity))}',
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
                            color: AppColor.primary,
                            width: 1), // Border cạnh trái
                        right: BorderSide(
                            color: AppColor.primary,
                            width: 1), // Border cạnh phải
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
                      child: Text(
                        'ĐẶT HÀNG NGAY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
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
