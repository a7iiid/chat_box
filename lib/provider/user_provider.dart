import 'package:chat_app/model/user.dart';
import 'package:chat_app/servise/db_servise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../model/chat.dart';

enum UserStat {
  initUser,
  loadingUser,
  userLoaded,
  userError,
  userNotLoaded,
  userNotLoadedError,
  loadingConversation,
  loadingMessages,
  successLoadMessage,
  successLoadConversation,
  successLoadUser,
  successLoadUserConversation,
  successLoadUserMessage,
  errorLoadUserMessage,
}

class UserProvider with ChangeNotifier {
  static UserProvider get(context) => Provider.of<UserProvider>(context);
  UserModel? user;
  UserStat userStat = UserStat.initUser;
  List<UserModel>? listUsers;
  List<Chat>? chates;
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

  Future<void> loadChatUser() async {
    userStat = UserStat.loadingConversation;
    notifyListeners();
    try {
      chates = await DbService.instance.loadChatUser();
      userStat = UserStat.successLoadMessage;
    } catch (_) {
      userStat = UserStat.errorLoadUserMessage;
    }
    notifyListeners();
  }
}
