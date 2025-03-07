import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<dynamic> images; // Chấp nhận List<dynamic>
  final int imagesPerRow;
  final Function(String) onImageTap;

  const ImageGrid({
    super.key,
    required this.images,
    this.imagesPerRow = 4,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 8;
    double itemSize =
        (screenWidth - (spacing * (imagesPerRow - 1))) / imagesPerRow;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: images.map((imagePath) {
        String imageUrl = imagePath is String
            ? imagePath
            : imagePath.toString(); // Ép kiểu về String
        return GestureDetector(
          onTap: () => onImageTap(imageUrl),
          child: SizedBox(
            width: itemSize,
            height: itemSize,
            child: Image.network(
              // Thay vì Image.asset, đổi thành Image.network nếu ảnh từ URL
              imageUrl,
              width: itemSize,
              height: itemSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image), // Xử lý lỗi ảnh
            ),
          ),
        );
      }).toList(),
    );
  }
}
