// ignore_for_file: deprecated_member_use, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/app_bar.dart';
import 'package:tlego_world/feature/create/components/checkout_button.dart';
import 'package:tlego_world/feature/create/components/payment_method_box.dart';
import 'package:tlego_world/feature/create/components/products_box.dart';
import 'package:tlego_world/feature/create/components/total_box.dart';
import 'package:tlego_world/feature/create/components/user_info_box.dart';
import 'package:tlego_world/feature/create/final_step_order.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/order_service.dart';
import 'package:tlego_world/services/product_service.dart';
import 'package:tlego_world/utils/random_price.dart';

class CheckoutBuyNow extends StatefulWidget {
  final String proID;
  final String guestPhone;
  final String guestName;
  final String guestAddress;
  final String province;
  final String district;
  final String ward;
  final int proQuantity;
  final bool isAccount;
  const CheckoutBuyNow(
      {super.key,
      required this.proID,
      required this.proQuantity,
      required this.guestPhone,
      required this.guestName,
      required this.guestAddress,
      required this.province,
      required this.district,
      required this.ward,
      required this.isAccount});

  @override
  State<CheckoutBuyNow> createState() => _CheckoutBuyNowState();
}

class _CheckoutBuyNowState extends State<CheckoutBuyNow> {
  String userId = "";

  late Future<Map<String, dynamic>?> _proFuture;
  double totalPrice = 0;
  double totalPriceWithShipVoucher = 0;
  int totalProduct = 0;
  String selectedPayment = "Thanh toán khi nhận hàng";
  // Random ship + voucher
  int total_shipping = getRandomAmount();
  int total_voucher = getRandomVoucher();

  @override
  void initState() {
    super.initState();
    userId = AuthHelper.getUserId();
    _proFuture = ProductService.getProByID(widget.proID);
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
            child: FutureBuilder<Map<String, dynamic>?>(
              future: _proFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi: ${snapshot.error}"));
                }

                final products = snapshot.data ?? [];
                final product = products as Map<String, dynamic>;

                // print(product['pro_price'] as double);
                totalPrice = product['pro_price'].toDouble() *
                    widget.proQuantity.toDouble();

                totalPriceWithShipVoucher = product['pro_price'].toDouble() *
                        widget.proQuantity.toDouble() +
                    total_shipping -
                    total_voucher;
                print(totalPrice);

                // print('Thông tin đơn hàng: ${product}\n'
                //     '- Mã sản phẩm: ${widget.proID}\n'
                //     '- Số điện thoại khách: ${widget.guestPhone}\n'
                //     '- Tên khách: ${widget.guestName}\n'
                //     '- Địa chỉ: ${widget.guestAddress}\n'
                //     '- Tỉnh/Thành phố: ${widget.province}\n'
                //     '- Quận/Huyện: ${widget.district}\n'
                //     '- Phường/Xã: ${widget.ward}\n'
                //     '- Số lượng sản phẩm: ${widget.proQuantity}');

                return Column(
                  children: [
                    // ==>> Khối thông tin
                    UserNoAccoutInfo(
                        guestName: widget.guestName,
                        guestPhone: widget.guestPhone,
                        guestAddress: widget.guestAddress,
                        province: widget.province,
                        district: widget.district,
                        ward: widget.ward),
                    const SizedBox(height: 16),
                    // ==>> Khối sản phẩm đã chọn
                    ProductBoxFromBuyNow(
                      products: products,
                      proQuantity: widget.proQuantity,
                    ),
                    const SizedBox(height: 16),

                    // ==>> Khối chọn phương thức thanh toán
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
                    CheckoutButton(
                        haveAccount: widget.isAccount,
                        proID: widget.proID,
                        guestPhone: widget.guestPhone,
                        guestName: widget.guestName,
                        guestAddress: widget.guestAddress,
                        province: widget.province,
                        district: widget.district,
                        ward: widget.ward,
                        proQuantity: widget.proQuantity,
                        totalShipping: total_shipping.toDouble(),
                        orderImage: product['pro_img'],
                        proPrice: product['pro_price'].toDouble(),
                        proName: product['pro_name'],
                        totalPrice: totalPriceWithShipVoucher,
                        selectedPayment: selectedPayment)
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
