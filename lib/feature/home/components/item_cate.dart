import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> images;
  final int imagesPerRow;
  final Function(String) onImageTap;
  final List<String> title;
  final double spacing; // Thêm khoảng cách tùy chỉnh
  final void Function(int index)? onTap;

  const ImageGrid({
    super.key,
    required this.images,
    this.imagesPerRow = 4,
    required this.onImageTap,
    required this.title,
    required this.onTap,
    this.spacing = 8, // Giá trị mặc định là 8
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemSize =
        (screenWidth - (spacing * (imagesPerRow - 1))) / imagesPerRow;

    return Wrap(
      spacing: spacing, // Khoảng cách ngang
      runSpacing: spacing, // Khoảng cách dọc
      children: images.asMap().entries.map((entry) {
        int index = entry.key;
        String imageUrl = entry.value;
        String imageTitle = index < title.length ? title[index] : "No Title";

        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!(index); // Gọi hàm onTap với index
            }
          },
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
              const SizedBox(height: 4),
              SizedBox(
                width: itemSize,
                child: Text(
                  imageTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF808080),
                    fontSize: 12,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
