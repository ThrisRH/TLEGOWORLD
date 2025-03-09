import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> images; // Danh sách đường dẫn ảnh
  final int imagesPerRow;
  final Function(String) onImageTap;
  final List<String> title; // Danh sách tiêu đề tương ứng với ảnh

  const ImageGrid({
    super.key,
    required this.images,
    this.imagesPerRow = 4,
    required this.onImageTap,
    required this.title,
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
      children: images.asMap().entries.map((entry) {
        int index = entry.key;
        String imageUrl = entry.value;
        String imageTitle = index < title.length
            ? title[index]
            : "No Title"; // Tránh lỗi index out of range

        return GestureDetector(
          onTap: () => onImageTap(imageUrl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                imageUrl,
                width: itemSize,
                height: itemSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
              const SizedBox(height: 4), // Khoảng cách giữa ảnh và chữ
              Text(
                imageTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF808080),
                    fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
