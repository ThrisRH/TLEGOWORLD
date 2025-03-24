import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/feature/login/view/login_main.dart';
import 'package:tlego_world/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  children: [
                    Image.asset('lib/assets/png/app_logo_auth.png', width: 250),
                    const SizedBox(height: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            floatingLabelStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColor.darkBlue,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.lightGray,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.darkBlue,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            labelText: 'Gmail của bạn',
                            labelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.lightGray,
                            ),
                            hintText: 'Ví dụ: abc@gmail.com',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                        ),
                        const SizedBox(height: 12),
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
                              fontSize: 16,
                              color: AppColor.darkBlue,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.lightGray,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.darkBlue,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            labelText: 'Mật khẩu',
                            labelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.lightGray,
                            ),
                            hintText: 'Ví dụ: Chubaduy@123',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                        ),
                        // Nhập lại mật khẩu
                        const SizedBox(height: 12),
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
                              fontSize: 16,
                              color: AppColor.darkBlue,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.lightGray,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColor.darkBlue,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            labelText: 'Nhập lại mật khẩu',
                            labelStyle: const TextStyle(fontSize: 12),
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.lightGray,
                            ),
                            hintText: 'Ví dụ: Chubaduy@123',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await AuthService().signup(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            height: 56,
                            child: const Text(
                              'ĐĂNG KÝ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        // >>> Trở về đăng nhập
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: AppColor.primary),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            height: 56,
                            child: const Text(
                              'ĐĂNG NHẬP',
                              style: TextStyle(
                                  color: AppColor.primary, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
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
