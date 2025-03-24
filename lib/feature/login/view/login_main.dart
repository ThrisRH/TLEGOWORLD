import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/register/register.dart';
import 'package:tlego_world/services/auth_service.dart';
import 'package:tlego_world/feature/navbar/navbar_main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height - 32),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'lib/assets/png/app_logo_auth.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            floatingLabelStyle: const TextStyle(
                                fontSize: 16, color: AppColor.darkBlue),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColor.lightGray),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColor.darkBlue),
                                borderRadius: BorderRadius.circular(24)),
                            labelText: 'Tên đăng nhập',
                            labelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(
                                fontSize: 12, color: AppColor.lightGray),
                            hintText: 'Ví dụ: Nguyễn Văn A',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() {
                                isObscure = !isObscure;
                              }),
                              child: const Icon(Icons.remove_red_eye_rounded),
                            ),
                            floatingLabelStyle: const TextStyle(
                                fontSize: 16, color: AppColor.darkBlue),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColor.lightGray),
                                borderRadius: BorderRadius.circular(24)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColor.darkBlue),
                                borderRadius: BorderRadius.circular(24)),
                            labelText: 'Mật khẩu',
                            labelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(
                                fontSize: 12, color: AppColor.lightGray),
                            hintText: 'Ví dụ: Chubaduy@123',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await AuthService().signin(
                                // Nếu trả về true tức là login thành công sẽ trả về home
                                email: _emailController.text,
                                // ignore: use_build_context_synchronously
                                password: _passwordController.text)
                            ? Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Navbar()))
                            : "";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(24)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        height: 56,
                        child: const Text(
                          'ĐĂNG NHẬP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: AppColor.primary),
                            borderRadius: BorderRadius.circular(24)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        height: 56,
                        child: const Text(
                          'ĐĂNG KÝ',
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
