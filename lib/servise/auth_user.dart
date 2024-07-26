import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cloud_storeg_servise.dart';
import 'db_servise.dart';
import 'media_servise.dart';

class AuthUser {
  static Future<String> logIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      return "Failed";
    }
  }

  static Future<String> signUp(
      BuildContext context, String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      MediaService mediaService =
          Provider.of<MediaService>(context, listen: false);
      if (mediaService.image != null) {
        var image = await CloudStorageServise.instance
            .uploadUserImage(user!.uid, mediaService.image!);
        await DbService.instance.creatUserDb(name, email, user.uid, image);
      }

      await user!.updateDisplayName(name);
      return "create user";
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
