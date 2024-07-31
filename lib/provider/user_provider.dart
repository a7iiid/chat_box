import 'dart:async';
import 'dart:developer';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/servise/db_servise.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<UserModel>? users;
  Conversation? _selectConversation;
  UserModel? _selecteUser;
  UserModel? get selectUser => _selecteUser;
  set selectUser(UserModel? user) {
    _selecteUser = user;
    notifyListeners();
  }

  Conversation? get selectConversation => _selectConversation;

  set selectConversation(Conversation? conversation) {
    _selectConversation = conversation;

    notifyListeners();
  }

  Future<void> loadAllUserData() async {
    userStat = UserStat.loadingUser;
    notifyListeners();
    try {
      users = await DbService.instance.loadAllUsersData();
      for (UserModel u in users!) {
        if (u.id == FirebaseAuth.instance.currentUser!.uid) {
          user = u;
          break;
        }
      }
      userStat = UserStat.userLoaded;
    } on Exception catch (_) {
      userStat = UserStat.userError;
    }
    notifyListeners();
  }
}
