import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  static Future<String> logIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      return "Filde";
    }
  }
}
