import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';

class NoProInCart extends StatelessWidget {
  const NoProInCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset('lib/assets/images/lego_pics/empty_cart.png'),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Bạn chưa có sản phẩm nào trong giỏ hàng !',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.mateGray)),
              SizedBox(
                height: 6,
              ),
              Text('Hãy lựa chọn và thêm sản phẩm vào giỏ hàng.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.normalGray,
                  )),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Navbar()));
            },
            child: const Text('Bắt đầu mua sắm',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.primaryBlue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primaryBlue,
                    decorationThickness: 1,
                    height: 1)),
          )
        ],
      ),
    );
  }
}