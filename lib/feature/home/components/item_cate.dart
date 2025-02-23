import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> images;
  final int imagesPerRow; // Số ảnh trên mỗi dòng

  const ImageGrid({super.key, required this.images, this.imagesPerRow = 4});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 8; // Khoảng cách giữa các ảnh
    double itemSize =
        (screenWidth - (spacing * (imagesPerRow - 1))) / imagesPerRow;

    return Wrap(
      spacing: spacing, // Khoảng cách ngang giữa ảnh
      runSpacing: spacing, // Khoảng cách dọc giữa ảnh
      children: images.map((imagePath) {
        return SizedBox(
          width: itemSize,
          child: Image.asset(
            imagePath,
            width: itemSize,
            height: itemSize,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}
