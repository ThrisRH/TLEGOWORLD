import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/login/view/login_main.dart';

class UnLogin extends StatelessWidget {
  const UnLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset('lib/assets/images/lego_pics/un_login.png'),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Bạn chưa đăng nhập vào TLegoWorld!',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.mateGray)),
              SizedBox(
                height: 6,
              ),
              Text('Hãy đăng nhập vào hệ thống để thêm vào giỏ hàng.',
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text('Đăng nhập ngay',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.primaryBlue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primaryBlue,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 1,
                    height: 1)),
          )
        ],
      ),
    );
  }
}