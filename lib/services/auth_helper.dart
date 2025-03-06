import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static String getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.email ?? 'none';
  }
}
