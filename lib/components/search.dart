import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';

class SearchBarbtn extends StatelessWidget {
  final VoidCallback onCartTap;

  const SearchBarbtn({Key? key, required this.onCartTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Container(
                  width: 32,
                  height: 32,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primary,
                  ),
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.white,
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColor.primary,
                ),
                hintText: 'Tìm kiếm sản phẩm bạn quan tâm',
                hintStyle: const TextStyle(color: AppColor.normalGray),
                filled: true,
                fillColor: const Color.fromARGB(255, 241, 241, 241),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onCartTap,
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF28282B),
            ),
          ),
        ],
      ),
    );
  }
}
