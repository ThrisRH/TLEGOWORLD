// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/app_bar.dart';
import 'package:tlego_world/components/box_info.dart';
import 'package:tlego_world/feature/create/components/total_box.dart';
import 'package:tlego_world/feature/create/final_step_order.dart';
import 'package:tlego_world/feature/payment/view/payment_main.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/auth_service.dart';
import 'package:tlego_world/services/cart_service.dart';
import 'package:tlego_world/services/order_service.dart';
import 'package:tlego_world/utils/format_currency.dart';
import 'package:tlego_world/utils/format_phone_number.dart';
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
                    const UserInfoBox(),
                    const SizedBox(height: 16),
                    BoxInfo(
                      title: 'Chi tiết đơn hàng',
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.lightGray),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Dash(
                                length: MediaQuery.of(context).size.width - 98,
                                dashColor: AppColor.lightGray,
                              ),
                            ),
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final item = products[index];

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(
                                        item['pro_img'],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['pro_name'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: AppColor.mateGray,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Số lượng: ${item['pro_quantity'].toString()}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColor.normalGray,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            formatCurrency(item['pro_price']),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TotalBox(
                      total_priceAllOfProducts: totalPrice,
                      total_shipping: total_shipping,
                      voucher: total_voucher,
                      products_count: totalProduct,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        print(products.length);
                        String id = getRandomIDItem();
                        String userId = AuthHelper.getUserId();
                        String imageFirst = "";
                        String proNameFirst = "";
                        double total_order = 0;
                        for (int i = 0; i < products.length; i++) {
                          if (i == 0) {
                            imageFirst = products[i]['pro_img'];
                            proNameFirst = products[i]['pro_name'];
                          }
                          total_order += products[i]['pro_price'] *
                              products[i]['pro_quantity'];
                          OrderService.createOrderItem(
                              order_id: id,
                              order_price: products[i]['pro_price'].toDouble(),
                              order_quantity: products[i]['pro_quantity'],
                              order_name: products[i]['pro_name']);

                          print(
                            '${id}, ${products[i]['pro_price'].toString()}, ${products[i]['pro_name']}, ${products[i]['pro_quantity']}',
                          );
                        }

                        print('img: ${imageFirst}');

                        double totalAll = total_order + total_shipping;

                        print(
                            "Ngày ${DateTime.now().toString()}, id: $id, cus: ${AuthHelper.getUserId()}, ");
                        OrderService.createOrderDetails(
                            cus_id: AuthHelper.getUserId(),
                            deliveryFee: total_shipping.toDouble(),
                            order_date: DateTime.now().day.toString(),
                            order_expected_day: (DateTime.now()).toString(),
                            order_id: id,
                            order_img: imageFirst,
                            order_price: total_order,
                            order_status: "chờ vận chuyển",
                            pro_name: proNameFirst,
                            total_price: totalAll);

                        CartService.clearUserCart(userId);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VnPayQR(
                                      vnpayUrl:
                                          'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Version=2.1.0&vnp_Command=pay&vnp_TmnCode=2QXUI4J4&vnp_Amount=5000000&vnp_CurrCode=VND&vnp_TxnRef=123456&vnp_OrderInfo=Test%20Thanh%20Toan&vnp_OrderType=other&vnp_Locale=vn&vnp_ReturnUrl=https%3A%2F%2Fyour-backend.com%2Fvnpay_return&vnp_IpAddr=127.0.0.1&vnp_CreateDate=20240320153000&vnp_SecureHash=6a8f3b3a9f89e01c13bd9f8d1dd5d84c',
                                      amount: 5000000,
                                    )));
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

class UserInfoBox extends StatefulWidget {
  const UserInfoBox({super.key});

  @override
  State<UserInfoBox> createState() => _UserInfoBoxState();
}

class _UserInfoBoxState extends State<UserInfoBox> {
  late Future<dynamic> _userFuture;

  @override
  void initState() {
    super.initState();
    String userId = AuthHelper.getUserId();
    print('User ID: $userId');
    _userFuture = AuthService.getUserInfo(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BoxInfo(
      title: 'Thông tin người mua',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGray),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4))),
        child: FutureBuilder<dynamic>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator()); // Đang tải dữ liệu
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Lỗi: ${snapshot.error}")); // Báo lỗi nếu có
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("Không có dữ liệu")); // Không có dữ liệu hợp lệ
              }

              @override
              final userInfo = snapshot.data!;
              print('${userInfo}');

              return (userInfo['cus_address'] == "" ||
                      userInfo['cus_name'] == "" ||
                      userInfo['cus_phone'] == "" ||
                      userInfo['cus_email'] == "" ||
                      userInfo['cus_id'] == "")
                  ? const NoInfo()
                  : HaveInfo(
                      cus_name: userInfo['cus_name'],
                      cus_phone: userInfo['cus_phone'],
                      cus_address: userInfo['cus_address'],
                    );
            }),
      ),
    );
  }
}

class HaveInfo extends StatefulWidget {
  final String cus_name;
  final String cus_phone;
  final String cus_address;
  const HaveInfo(
      {super.key,
      required this.cus_name,
      required this.cus_phone,
      required this.cus_address});

  @override
  State<HaveInfo> createState() => _HaveInfoState();
}

class _HaveInfoState extends State<HaveInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          widget.cus_name,
          style: const TextStyle(
              color: AppColor.mateGray,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        // PhoneNumber
        const SizedBox(
          height: 6,
        ),
        Text(
          formatPhoneNumber(widget.cus_phone),
          style: const TextStyle(
            color: AppColor.normalGray,
            fontSize: 14,
          ),
          textAlign: TextAlign.left,
        ),
        // Address
        const SizedBox(
          height: 6,
        ),
        Text(
          widget.cus_address,
          style: const TextStyle(
            color: AppColor.normalGray,
            fontSize: 14,
          ),
          textAlign: TextAlign.left,
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'Cập nhật thông tin',
            style: TextStyle(
                color: AppColor.primaryBlue,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.primaryBlue),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class NoInfo extends StatelessWidget {
  const NoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'lib/assets/images/lego_pics/no_info.png',
            width: 138,
            height: 138,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Text(
          'Bạn chưa có thông tin nhận hàng!',
          style: TextStyle(color: AppColor.mateGray),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 6,
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'Cập nhật ngay',
            style: TextStyle(
                color: AppColor.primaryBlue,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.primaryBlue),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
