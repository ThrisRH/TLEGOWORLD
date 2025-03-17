// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/box_info.dart';
import 'package:tlego_world/utils/format_currency.dart';

class TotalBox extends StatefulWidget {
  final double total_priceAllOfProducts;
  final int products_count;
  final int total_shipping;
  final int voucher;

  const TotalBox(
      {super.key,
      required this.total_priceAllOfProducts,
      required this.total_shipping,
      required this.voucher,
      required this.products_count});

  @override
  State<TotalBox> createState() => _TotalBoxState();
}

class _TotalBoxState extends State<TotalBox> {
  @override
  Widget build(BuildContext context) {
    return BoxInfo(
      title: "Tổng cộng",
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGray),
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(4),
                bottomLeft: Radius.circular(4))),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// Tổng giá sản phẩm
            Row(
              children: [
                Text('Tổng sản phẩm (${widget.products_count}):',
                    style: const TextStyle(
                        fontSize: 14, color: AppColor.mateGray)),
                const Spacer(),
                Text(
                    '${formatCurrency(widget.total_priceAllOfProducts.toInt())}',
                    style:
                        const TextStyle(fontSize: 14, color: AppColor.mateGray))
              ],
            ),
            const SizedBox(
              height: 6,
            ),

            /// Tổng phí vận
            Row(
              children: [
                const Text('Phí vận chuyển:',
                    style: TextStyle(fontSize: 14, color: AppColor.mateGray)),
                const Spacer(),
                Text('${formatCurrency(widget.total_shipping.toInt())}',
                    style:
                        const TextStyle(fontSize: 14, color: AppColor.mateGray))
              ],
            ),
            const SizedBox(
              height: 6,
            ),

            /// Tổng voucher
            Row(
              children: [
                const Text(
                  'Mã giảm giá:',
                  style: TextStyle(fontSize: 14, color: AppColor.mateGray),
                ),
                const Spacer(),
                Text('- ${formatCurrency(widget.voucher)}',
                    style:
                        const TextStyle(fontSize: 14, color: AppColor.mateGray))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Text(
                  'Tổng đơn hàng:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  ('${formatCurrency((widget.total_priceAllOfProducts.toInt() + widget.total_shipping.toInt() - widget.voucher))}')
                      .toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
