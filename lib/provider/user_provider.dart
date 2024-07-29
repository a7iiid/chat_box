import 'package:chat_app/feturs/home/data/model/user.dart';
import 'package:chat_app/servise/db_servise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

enum UserStat {
  initUser,
  loadingUser,
  userLoaded,
  userError,
  userNotLoaded,
  userNotLoadedError,
  loadingConversation
}

class UserProvider with ChangeNotifier {
  static UserProvider get(context) => Provider.of<UserProvider>(context);
  UserModel? user;
  UserStat userStat = UserStat.initUser;
  List<UserModel>? listUsers;
  Future<void> loadUserData() async {
    userStat = UserStat.loadingUser;
    notifyListeners();
    try {
      user = await DbService.instance.loadUserData();
      userStat = UserStat.userLoaded;
    } on Exception catch (_) {
      userStat = UserStat.userError;
    }
    notifyListeners();
  }

  Future<void> loadConversation() async {
    userStat = UserStat.loadingUser;
    notifyListeners();
    try {
      user = await DbService.instance.loadUserData();
      userStat = UserStat.userLoaded;
    } on Exception catch (_) {
      userStat = UserStat.userError;
    }
    notifyListeners();
  }
}
