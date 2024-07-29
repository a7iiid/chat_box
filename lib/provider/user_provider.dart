import 'package:chat_app/feturs/home/data/model/user.dart';
import 'package:chat_app/servise/db_servise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

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
  static UserProvider get(context) => UserProvider();
  UserModel? _user;
  UserStat _userStat = UserStat.initUser;
  List<UserModel>? listUsers;
  Future<void> loadUserData() async {
    _userStat = UserStat.loadingUser;
    notifyListeners();
    try {
      _user = await DbService.instance.loadUserData();
      _userStat = UserStat.userLoaded;
    } on Exception catch (_) {
      _userStat = UserStat.userError;
    }
    notifyListeners();
  }
}
