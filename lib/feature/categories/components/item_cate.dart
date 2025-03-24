import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> images;
  final int imagesPerRow;
  final Function(String) onImageTap; // Hàm callback khi bấm vào ảnh

  const ImageGrid({
    super.key,
    required this.images,
    this.imagesPerRow = 4,
    required this.onImageTap, // Nhận hàm điều hướng từ màn hình cha
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 12; // Khoảng cách giữa các ảnh
    double itemSize =
        (screenWidth - (spacing * (imagesPerRow - 1))) / imagesPerRow;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: images.map((imagePath) {
        return GestureDetector(
          onTap: () {
            onImageTap(imagePath); // Gọi hàm điều hướng do bạn chỉ định
          },
          child: SizedBox(
            width: itemSize,
            child: Image.asset(
              imagePath,
              width: itemSize,
              height: itemSize,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
