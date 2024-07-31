import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/utils/router/routs.dart';
import '../provider/user_provider.dart';
import 'cloud_storeg_servise.dart';
import 'db_servise.dart';
import 'media_servise.dart';

class AuthUser {
  static Future<String> logIn(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await Provider.of<UserProvider>(context, listen: false).loadUserData();
      await Provider.of<UserProvider>(context, listen: false).loadAllUserData();
      GoRouter.of(context).pushReplacement(Routes.kHomePage);

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
        await DbService.instance.createUserDb(name, email, user.uid, image);
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
