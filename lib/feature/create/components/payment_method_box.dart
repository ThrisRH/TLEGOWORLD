import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/box_info.dart';

class PaymentMethodSelection extends StatefulWidget {
  final Function(String) onPaymentMethodSelected;
  const PaymentMethodSelection(
      {super.key, required this.onPaymentMethodSelected});

  @override
  State<PaymentMethodSelection> createState() => _PaymentMethodSelectionState();
}

class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
  String? selectedPayment;

  final List<String> paymentMethods = [
    "Thanh toán khi nhận hàng",
    "Thanh toán trực tuyến",
  ];

  @override
  Widget build(BuildContext context) {
    return BoxInfo(
      title: 'Phương thức thanh toán',
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGray),
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(4),
                bottomLeft: Radius.circular(4))),
        padding: const EdgeInsets.all(12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedPayment,
            hint: const Text("Thanh toán khi nhận hàng"),
            isExpanded: true,
            items: paymentMethods.map((String method) {
              return DropdownMenuItem<String>(
                value: method,
                child: Text(method),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedPayment = newValue;
              });

              if (newValue != null) {
                widget.onPaymentMethodSelected(newValue); // Gửi giá trị lên cha
              }
            },
          ),
        ),
      ),
    );
  }
}
