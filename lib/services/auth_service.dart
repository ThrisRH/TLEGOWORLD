import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tlego_world/assets/color/colors.dart';

class AuthService {
  Future<bool> signup({
    required String email,
    required String password,
  }) async {
    try {
      // print('Email: $email');
      // print('Email: $password');
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Kiểm tra nếu user đã được tạo thành công
      if (userCredential.user != null) {
        try {
          final response = await http.post(
            Uri.parse("http://3.25.92.254:5000/api/customers"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "cus_email": email,
              "cus_id": userCredential.user?.uid,
              "cus_address": "",
              "cus_name": "",
              "cus_phone": ""
            }),
          );
          // print("Status Code: ${response.statusCode}");
          // print("Response: ${response.body}");

          if (response.statusCode >= 200 && response.statusCode < 300) {
            Fluttertoast.showToast(
              msg: "Đăng ký thành công!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              // ignore: deprecated_member_use
              backgroundColor: AppColor.mateGray.withOpacity(0.3),
              textColor: AppColor.mateGray,
              fontSize: 12,
            );
            return true; // Thêm thành công
          } else {
            return false; // Lỗi từ server
          }
        } catch (e) {
          print("Lỗi khi lấy giỏ hàng: $e");
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Email hoặc password không hợp lệ!';
      if (e.code == 'week-password') {
        message = 'Mật khẩu quá yếu!';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email đã tồn tại';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        // ignore: deprecated_member_use
        backgroundColor: AppColor.mateGray.withOpacity(0.3),
        textColor: AppColor.mateGray,
        fontSize: 12,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Lỗi không xác định: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: AppColor.mateGray.withOpacity(0.3),
        textColor: AppColor.mateGray,
        fontSize: 12,
      );
    }
    return false;
  }

  Future<bool> signin({
    required String email,
    required String password,
  }) async {
    try {
      print('Email: $email');
      print('Password: $password');
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Fluttertoast.showToast(
          msg: "Đăng nhập thành công!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          // ignore: deprecated_member_use
          backgroundColor: AppColor.mateGray.withOpacity(0.3),
          textColor: AppColor.mateGray,
          fontSize: 12,
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Email hoặc mật khẩu không đúng';
      if (e.code == 'user-not-found') {
        message = 'Người dùng không tồn tại!';
      } else if (e.code == 'wrong-password') {
        message = 'Sai mật khẩu!';
      } else {
        message = 'Lỗi: ${e.code}'; // Debug lỗi Firebase
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        // ignore: deprecated_member_use
        backgroundColor: AppColor.mateGray.withOpacity(0.3),
        textColor: AppColor.mateGray,
        fontSize: 12,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Lỗi không xác định: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: AppColor.mateGray.withOpacity(0.3),
        textColor: AppColor.mateGray,
        fontSize: 12,
      );
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(
        msg: 'Đăng xuất thành công',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        // ignore: deprecated_member_use
        backgroundColor: AppColor.mateGray.withOpacity(0.3),
        textColor: AppColor.mateGray,
        fontSize: 12,
      );
      return true;
    } catch (e) {
      print("Lỗi khi đăng xuất: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.139.125:5000/api/customers/userInfo/$userId"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic>) {
          return data; // Trả về object đúng kiểu Map
        } else {
          return null;
        }
      } else {
        throw Exception("Lỗi: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin người dùng: $e");
      return null;
    }
  }
}
