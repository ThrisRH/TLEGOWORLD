import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/box_info.dart';
import 'package:tlego_world/utils/format_currency.dart';

class ProductsBox extends StatefulWidget {
  final List<dynamic> products;
  const ProductsBox({super.key, required this.products});

  @override
  State<ProductsBox> createState() => _ProductsBoxState();
}

class _ProductsBoxState extends State<ProductsBox> {
  @override
  Widget build(BuildContext context) {
    return BoxInfo(
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
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            final item = widget.products[index];

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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}

class ProductBoxFromBuyNow extends StatefulWidget {
  final Map<String, dynamic>? products;
  final int proQuantity;
  const ProductBoxFromBuyNow(
      {super.key, this.products, required this.proQuantity});

  @override
  State<ProductBoxFromBuyNow> createState() => _ProductBoxFromBuyNowState();
}

class _ProductBoxFromBuyNowState extends State<ProductBoxFromBuyNow> {
  @override
  Widget build(BuildContext context) {
    return BoxInfo(
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
          itemCount: 1,
          itemBuilder: (context, index) {
            final item = widget.products as Map<String, dynamic>;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Số lượng: ${widget.proQuantity.toString()}',
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
    );
  }
}
