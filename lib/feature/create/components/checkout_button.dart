import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/create/final_step_order.dart';
import 'package:tlego_world/services/auth_helper.dart';
import 'package:tlego_world/services/order_service.dart';
import 'package:tlego_world/utils/random_price.dart';

class CheckoutButton extends StatefulWidget {
  final String proID;
  final String guestPhone;
  final String guestName;
  final String guestAddress;
  final String province;
  final String district;
  final String ward;
  final int proQuantity;
  final double totalShipping;
  final String orderImage;
  final double proPrice;
  final String proName;
  final double totalPrice;
  final String selectedPayment;
  final bool haveAccount;
  const CheckoutButton(
      {super.key,
      required this.proID,
      required this.guestPhone,
      required this.guestName,
      required this.guestAddress,
      required this.province,
      required this.district,
      required this.ward,
      required this.proQuantity,
      required this.totalShipping,
      required this.orderImage,
      required this.proPrice,
      required this.proName,
      required this.totalPrice,
      required this.selectedPayment,
      required this.haveAccount});

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!widget.haveAccount) {
          bool isCreated = await OrderService.createOrderForGuest(
              pro_ID: widget.proID,
              order_id: getRandomIDItem(),
              guest_phone: widget.guestPhone,
              guest_fullname: widget.guestName,
              guest_provicecity: widget.province,
              guest_district: widget.district,
              guest_wardcommue: widget.ward,
              guest_streethouse: widget.guestAddress,
              deliveryFee: widget.totalShipping,
              order_date:
                  "${DateTime.now().toUtc().toIso8601String().split('.').first}Z",
              order_img: widget.orderImage,
              order_price: widget.proPrice,
              order_status: 'Chờ xác nhận',
              pro_name: widget.proName,
              total_price: widget.totalPrice,
              order_quantity: widget.proQuantity,
              payment_method: widget.selectedPayment,
              payment_status: 'Chờ thanh toán');

          if (isCreated) {
            Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const FinalStep()),
                (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(
              msg: 'Đặt hàng thất bại!',
              backgroundColor: AppColor.falseColor,
              gravity: ToastGravity.TOP,
            );
          }
        } else {
          String id = getRandomIDItem();
          String userId = AuthHelper.getUserId();
          String imageFirst = "";
          String proNameFirst = "";
          final orderItem = await OrderService.createOrderItem(
            order_id: id,
            order_price: widget.proPrice,
            order_quantity: widget.proQuantity,
            order_name: widget.proName,
            pro_ID: widget.proID,
            pro_img: widget.orderImage,
          );
          print('orderItems: $orderItem');
          if (orderItem != null) {
            if (await OrderService.createOrderDetails(
                    cus_id: userId,
                    deliveryFee: widget.totalShipping,
                    order_date:
                        "${DateTime.now().toUtc().toIso8601String().split('.').first}Z",
                    order_expected_day:
                        "${DateTime.now().toUtc().toIso8601String().split('.').first}Z",
                    order_id: id,
                    order_img: widget.orderImage,
                    order_price: widget.proPrice,
                    order_status: "Đang chờ xác nhận",
                    pro_name: widget.proName,
                    total_price: widget.totalPrice,
                    payment_method: widget.selectedPayment,
                    payment_status: 'Chờ thanh toán') !=
                null) {
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FinalStep()));
            }
          } else {
            Fluttertoast.showToast(
                msg: 'Đặt hàng không thành công!',
                backgroundColor: AppColor.falseColor,
                gravity: ToastGravity.TOP);
          }

          // print(
          //     "Ngày ${DateTime.now().toString()}, id: $id, cus: ${AuthHelper.getUserId()}, ");
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
    );
  }
}
