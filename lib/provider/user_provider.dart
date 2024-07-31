import 'dart:async';
import 'dart:developer';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/servise/db_servise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<UserModel>? listUsers;
  Conversation? _selectConversation;
  final StreamController<Conversation> _conversationController =
      StreamController<Conversation>.broadcast();

  Stream<Conversation> get conversationStream => _conversationController.stream;

  Conversation? get selectConversation => _selectConversation;

  set selectConversation(Conversation? conversation) {
    _selectConversation = conversation;
    if (conversation != null) {
      _conversationController.add(conversation);
      _updateConversationInFirebase(conversation);
    }
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

  Future<void> _updateConversationInFirebase(Conversation conversation) async {
    if (_selectConversation == null) return;
    try {
      await DbService.instance.updateConversation(conversation);
    } catch (e) {
      log('Failed to update conversation in Firebase: $e');
    }
  }

  @override
  void dispose() {
    _conversationController.close();
    super.dispose();
  }
}
