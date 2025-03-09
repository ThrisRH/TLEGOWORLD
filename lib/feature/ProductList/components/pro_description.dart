import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDescription extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductDescription({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    const texttop = TextStyle(fontSize: 14, color: Colors.black);
    const textnote = TextStyle(fontSize: 18, color: Colors.black);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16), // Thêm padding dọc
          child: Text(
            'Mô tả sản phẩm',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1C),
            ),
          ),
        ),
        Text(
          productData['pro_description'],
          textAlign: TextAlign.justify, // Căn đều văn bản
          style: texttop,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('- Tên: ${productData['pro_name']}', style: texttop),
            const SizedBox(height: 8),
            Text('- Số mảnh ghép: ${productData['block_count']}',
                style: texttop),
            const SizedBox(height: 8),
            Text('- Mã số: ${productData['pro_ID']}', style: texttop),
            const SizedBox(height: 8),
            const Text('- Độ tuổi: 4+', style: texttop),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                'Cảnh báo! Chứa mảnh nhỏ. Không dành cho trẻ dưới 3 tuổi.',
                style: textnote,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8), // Tạo khoảng cách
            SvgPicture.asset(
              'lib/assets/svg/components/note_icon.svg',
            ),
          ],
        ),
        const SizedBox(height: 30),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cam đoan',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF1C1C1C),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Text('✅ Sản phẩm chất lượng.', style: texttop),
            SizedBox(height: 8),
            Text('✅ Đúng mô tả, đủ mảnh ghép.', style: texttop),
            SizedBox(height: 8),
            Text('✅ Bảo quản cẩn thận.', style: texttop),
            SizedBox(height: 8),
            Text('📦 Giao hàng toàn quốc', style: texttop),
            SizedBox(height: 8),
            Text('🚚 Xử lý nhanh chóng', style: texttop),
          ],
        ),
      ],
    );
  }
}
