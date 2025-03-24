import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Thêm tham số text để có thể chỉnh nội dung nút

  const RedButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Nút chiếm hết chiều rộng
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE1001A),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ), // Tăng chiều cao cho đẹp
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text, // Hiển thị nội dung động
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ShoppingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShoppingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: SvgPicture.asset(
            'lib/assets/svg/components/shopping_icon.svg',
          ),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDeleting;
  final String text; // Biến để thay đổi nội dung nút

  const CancelButton({
    Key? key,
    required this.onPressed,
    this.isDeleting = false,
    this.text = '', // Giá trị mặc định là "Hủy đơn"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDeleting ? null : onPressed, // Vô hiệu hóa khi đang xóa
      child: Container(
        width: double.infinity, // Chiếm toàn bộ chiều rộng
        padding: const EdgeInsets.symmetric(vertical: 12), // Tăng chiều cao nút
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE1001A),
            width: 2,
          ), // Viền đỏ
          borderRadius: BorderRadius.circular(12), // Bo góc
          color: Colors.white, // Nền trắng
        ),
        alignment: Alignment.center, // Canh giữa nội dung
        child: isDeleting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1001A)),
                ),
              ) // Vòng load
            : Text(
                text, // Sử dụng biến text
                style: const TextStyle(
                  color: Color(0xFFE1001A), // Chữ màu đỏ
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
      ),
    );
  }
}

class RatingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDeleting;
  final String text; // Biến để thay đổi nội dung nút

  const RatingButton({
    Key? key,
    required this.onPressed,
    this.isDeleting = false,
    this.text = '', // Giá trị mặc định là "Hủy đơn"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDeleting ? null : onPressed, // Vô hiệu hóa khi đang xóa
      child: Container(
        width: double.infinity, // Chiếm toàn bộ chiều rộng
        padding: const EdgeInsets.symmetric(vertical: 12), // Tăng chiều cao nút
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFFD500),
            width: 2,
          ), // Viền đỏ
          borderRadius: BorderRadius.circular(12), // Bo góc
          color: Colors.white, // Nền trắng
        ),
        alignment: Alignment.center, // Canh giữa nội dung
        child: isDeleting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD500)),
                ),
              ) // Vòng load
            : Text(
                text, // Sử dụng biến text
                style: const TextStyle(
                  color: Color(0xFFFFD500), // Chữ màu đỏ
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
      ),
    );
  }
}
