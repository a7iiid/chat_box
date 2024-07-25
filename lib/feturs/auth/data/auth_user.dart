import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<String> SignUp(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // if (pickImageServes.file != null) {
      //   await pickImageServes.uplode();

      //   await user?.updatePhotoURL(pickImageServes.url);
      // }
      await user?.updateDisplayName(name);
      await FirebaseFirestore.instance.collection("users").add({
        "name": name,
        "email": email,
      });
      return "creat user";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }
}
