import 'package:flutter/material.dart';
import 'package:tlego_world/feature/cart/cart_page.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CartPage()));
      },
      child: const Icon(
        Icons.shopping_cart_outlined,
        color: Color(0xFF28282B),
      ),
    );
  }
}
