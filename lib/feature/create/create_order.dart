// ignore_for_file: deprecated_member_use, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/app_bar.dart';
import 'package:tlego_world/components/component/button.dart';
import 'package:tlego_world/feature/create/components/payment_method_box.dart';
import 'package:tlego_world/feature/create/components/products_box.dart';
import 'package:tlego_world/feature/create/components/total_box.dart';
import 'package:tlego_world/feature/create/components/user_info_box.dart';
import 'package:tlego_world/feature/create/components/vietqr.dart';
import 'package:tlego_world/feature/create/final_step_order.dart';
import 'package:tlego_world/feature/payment/payments.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/cart_service.dart';
import 'package:tlego_world/services/order_service.dart';
import 'package:tlego_world/utils/random_price.dart';

class PaymentChecking extends StatefulWidget {
  const PaymentChecking({super.key});

  @override
  State<PaymentChecking> createState() => _PaymentCheckingState();
}

class _PaymentCheckingState extends State<PaymentChecking> {
  late Future<List<dynamic>> _cartFuture;
  double totalPrice = 0;
  int totalProduct = 0;
  // Random ship + voucher
  int total_shipping = getRandomAmount();
  int total_voucher = getRandomVoucher();
  String selectedPayment = "Thanh toán khi nhận hàng";

  @override
  void initState() {
    super.initState();
    String userId = AuthHelper.getUserId();
    print('User ID: $userId');
    _cartFuture = CartService.getUserCart(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: AppColor.lightGray.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ]),
            child: const AppBarTitle(title: 'THANH TOÁN'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            width: double.infinity,
            child: FutureBuilder<List<dynamic>>(
              future: _cartFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi: ${snapshot.error}"));
                }

                final products = snapshot.data ?? [];

                /// Tính tổng tiền và tổng số lượng sản phẩm
                double newTotalPrice = products.fold(0, (sum, item) {
                  final price =
                      double.tryParse(item["pro_price"].toString()) ?? 0;
                  final quantity = item["pro_quantity"] ?? 1;
                  return sum + (price * quantity);
                });

                int newTotalProduct = products.fold(0, (sum, item) {
                  final quantity =
                      int.tryParse(item["pro_quantity"].toString()) ?? 0;
                  return sum + quantity;
                });

                // Cập nhật state một lần
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (totalPrice != newTotalPrice ||
                      totalProduct != newTotalProduct) {
                    setState(() {
                      totalPrice = newTotalPrice;
                      totalProduct = newTotalProduct;
                    });
                  }
                });

                return Column(
                  children: [
                    // ==>> Khối thông tin
                    const UserInfoBox(),
                    const SizedBox(height: 16),
                    // ==>> Khối sản phẩm đã chọn
                    ProductsBox(
                      products: products,
                    ),
                    const SizedBox(height: 16),
                    // ==>> Khối phương thức thanh toán
                    PaymentMethodSelection(
                      onPaymentMethodSelected: (String payment) {
                        setState(() {
                          selectedPayment = payment;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    // ==>> Khối tổng tiền
                    TotalBox(
                      total_priceAllOfProducts: totalPrice,
                      total_shipping: total_shipping,
                      voucher: total_voucher,
                      products_count: totalProduct,
                    ),
                    const SizedBox(height: 16),

                    // ==>> Khối xử lý đặt hàng
                    GestureDetector(
                      onTap: () async {
                        print(products.length);

                        String id = getRandomIDItem();
                        String userId = AuthHelper.getUserId();
                        String imageFirst = "";
                        String proNameFirst = "";
                        double total_order = 0;

                        // Tính tổng giá trị đơn hàng trước khi xử lý
                        for (int i = 0; i < products.length; i++) {
                          if (i == 0) {
                            imageFirst = products[i]['pro_img'];
                            proNameFirst = products[i]['pro_name'];
                          }
                          total_order += products[i]['pro_price'] *
                              products[i]['pro_quantity'];
                        }

                        // Thêm các mục đơn hàng vào hệ thống
                        for (int i = 0; i < products.length; i++) {
                          await OrderService.createOrderItem(
                            order_id: id,
                            order_price: products[i]['pro_price'].toDouble(),
                            order_quantity: products[i]['pro_quantity'],
                            order_name: products[i]['pro_name'],
                            pro_ID: products[i]['pro_ID'],
                            pro_img: products[i]['pro_img'],
                          );
                        }

                        double totalAll = total_order +
                            total_shipping.toDouble() -
                            total_voucher.toDouble();

                        // Thêm thông tin đơn hàng vào hệ thống
                        bool orderCreated =
                            await OrderService.createOrderDetails(
                                  cus_id: userId,
                                  deliveryFee: total_shipping.toDouble(),
                                  order_date:
                                      "${DateTime.now().toUtc().toIso8601String().split('.').first}Z",
                                  order_expected_day:
                                      "${DateTime.now().toUtc().toIso8601String().split('.').first}Z",
                                  order_id: id,
                                  order_img: imageFirst,
                                  order_price: total_order,
                                  order_status: selectedPayment ==
                                          "Thanh toán khi nhận hàng"
                                      ? "Đang chờ xác nhận"
                                      : "Chờ thanh toán",
                                  pro_name: proNameFirst,
                                  total_price: totalAll,
                                  payment_method: selectedPayment,
                                  payment_status: selectedPayment ==
                                          "Thanh toán khi nhận hàng"
                                      ? "Chờ thanh toán"
                                      : "Đang xử lý",
                                ) !=
                                null;

                        if (!orderCreated) {
                          Fluttertoast.showToast(
                              msg: 'Đặt hàng không thành công!',
                              backgroundColor: AppColor.falseColor,
                              gravity: ToastGravity.TOP);
                          return;
                        }

                        if (selectedPayment == "Thanh toán khi nhận hàng") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FinalStep()),
                          );
                          CartService.clearUserCart(userId);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnlinePaymentScreen(
                                totalAll: totalAll,
                                id: id,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'ĐẶT HÀNG NGAY',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
