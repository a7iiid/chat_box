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
  StreamSubscription<List<UserModel>>? _userSubscription;
  StreamSubscription<List<Conversation>>? _conversationSubscription;

  set selectUser(UserModel? user) {
    _selecteUser = user;
    notifyListeners();
  }

  Conversation? get selectConversation => _selectConversation;

  set selectConversation(Conversation? conversation) {
    _selectConversation = conversation;

    notifyListeners();
  }

  void loadAllUserData() {
    userStat = UserStat.loadingUser;
    notifyListeners();

    _userSubscription = DbService.instance.streamAllUsersData().listen(
      (userList) {
        users = userList;
        for (UserModel u in users!) {
          if (u.id == FirebaseAuth.instance.currentUser!.uid) {
            user = u;
            break;
          }
        }
        userStat = UserStat.userLoaded;
        notifyListeners();
      },
      onError: (_) {
        userStat = UserStat.userError;
        notifyListeners();
      },
    );
  }

  void streamUserConversations() {
    if (user != null) {
      _conversationSubscription?.cancel();
      _conversationSubscription = DbService.instance
          .streamUserConversations(user!.id)
          .listen((conversations) {
        user!.conversation = conversations;
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    _conversationSubscription?.cancel();
    super.dispose();
  }
}
