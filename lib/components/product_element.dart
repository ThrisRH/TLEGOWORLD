import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tlego_world/assets/color/colors.dart';

class ProductElement extends StatefulWidget {
  final String pro_img;
  final String pro_name;
  final double pro_price;
  final int pro_quantity;

  const ProductElement(
      {super.key,
      required this.pro_img,
      required this.pro_name,
      required this.pro_price,
      required this.pro_quantity});

  @override
  State<ProductElement> createState() => _ProductElementState();
}

String formatCurrency(int amount) {
  return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(amount);
}

class _ProductElementState extends State<ProductElement> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.pro_quantity; // Gán giá trị ban đầu
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Hình ảnh sản phẩm
        Image.network(
          widget.pro_img,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 12),

        /// Phần chứa tên, giá và số lượng
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Tên sản phẩm + nút xóa
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Tên sản phẩm
                  Expanded(
                    child: Text(
                      widget.pro_name,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),

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

              const SizedBox(height: 12),

              /// **Giá và số lượng nằm cùng hàng**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// **Giá tiền**
                  FittedBox(
                    child: Text(
                      formatCurrency(widget.pro_price.toInt()),
                      style: const TextStyle(
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
                            if (widget.pro_quantity > 1) {
                              quantity -= 1;
                            }
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: widget.pro_quantity == 1
                                    ? AppColor.lightGray
                                    : AppColor.mateGray),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: widget.pro_quantity == 1
                                ? AppColor.lightGray
                                : AppColor.mateGray,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      /// Ô số lượng
                      Container(
                        width: 48,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.mateGray),
                        ),
                        child: Text(
                          widget.pro_quantity as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      /// Nút tăng
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.pro_quantity < 10) {
                              quantity += 1;
                            }
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: widget.pro_quantity == 10
                                    ? AppColor.lightGray
                                    : AppColor.mateGray),
                          ),
                          child: Icon(
                            Icons.add,
                            color: widget.pro_quantity == 10
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
    );
  }
}
