import 'dart:async';
import 'dart:developer';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/servise/db_servise.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

enum UserStat {
  initUser,
  loadingUser,
  userLoaded,
  userError,
  userNotLoaded,
  userNotLoadedError,
}

class UserProvider with ChangeNotifier {
  static UserProvider get(context) => Provider.of<UserProvider>(context);
  UserModel? user;
  UserStat userStat = UserStat.initUser;
  List<UserModel>? listUsers;
  Conversation? _selectConversation;

  Conversation? get selectConversation => _selectConversation;

  set selectConversation(Conversation? conversation) {
    _selectConversation = conversation;

    notifyListeners();
  }

  Future<void> loadUserData() async {
    userStat = UserStat.loadingUser;
    notifyListeners();
    try {
      user = await DbService.instance.loadUserData();
      log(user.toString());
      userStat = UserStat.userLoaded;
    } on Exception catch (_) {
      userStat = UserStat.userError;
    }
    notifyListeners();
  }
}
