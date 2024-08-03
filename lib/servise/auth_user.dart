import 'package:chat_app/core/utils/Key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

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
      Provider.of<UserProvider>(context, listen: false).loadAllUserData();
      GoRouter.of(context).pushReplacement(Routes.kHomePage);

      return "success";
    } catch (e) {
      return "Failed";
    }
  }

  static void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: ApiKey.AppID /*input your AppID*/,
      appSign: ApiKey.AppSign /*input your AppSign*/,
      userID: FirebaseAuth.instance.currentUser!.uid,
      userName: FirebaseAuth.instance.currentUser!.displayName!,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
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
