import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';

class FinalStep extends StatelessWidget {
  const FinalStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height,
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'lib/assets/images/lego_pics/successfully.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Đặt hàng thành công',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColor.trueColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Cảm ơn bạn',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.normalGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'đã mua hàng tại TLegoWorld',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.normalGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Đơn hàng sẽ được giao đến bạn sớm nhất!',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.normalGray,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(builder: (context) => const Navbar()),
                        (Route<dynamic> route) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'TRỞ VỀ TRANG CHỦ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
