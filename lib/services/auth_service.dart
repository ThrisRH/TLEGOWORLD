import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tlego_world/assets/color/colors.dart';

class AuthService {
  Future<bool> signup({
    required String email,
    required String password,
  }) async {
    try {
      print('Email: $email');
      print('Email: $password');
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Kiểm tra nếu user đã được tạo thành công
      if (userCredential.user != null) {
        Fluttertoast.showToast(
          msg: "Đăng ký thành công!",
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
}
