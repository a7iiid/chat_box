import 'dart:developer';

import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbService {
  static DbService instance = DbService();
  FirebaseFirestore _db;
  FirebaseStorage _storage;
  FirebaseAuth _authUser;
  String _userCollection = 'users';
  String _chatCollection = 'conversation';

  DbService()
      : _db = FirebaseFirestore.instance,
        _authUser = FirebaseAuth.instance,
        _storage = FirebaseStorage.instance;
  Future<void> creatUserDb(
      String name, String email, String uid, String image) async {
    await _db.collection(_userCollection).doc(uid).set({
      'name': name,
      'email': email,
      'image': image,
      'lastSeen': DateTime.now().toUtc()
    });
  }

  Future<UserModel> loadUserData() async {
    var userDoc = await FirebaseFirestore.instance
        .collection(_userCollection)
        .doc(_authUser.currentUser!.uid)
        .get();

    var conversationDocs = await FirebaseFirestore.instance
        .collection(_userCollection)
        .doc(_authUser.currentUser!.uid)
        .collection(_chatCollection)
        .get();
    log(conversationDocs.toString());
    log(userDoc.toString());

    List<Conversation> conversations = conversationDocs.docs
        .map((doc) => Conversation.fromJson(doc.data()))
        .toList();

    return UserModel.fromJson(
        userDoc.data() as Map<String, dynamic>, conversations);
  }

  Future<List<Chat>> loadChatUser() {
    return FirebaseFirestore.instance
        .collection(_chatCollection)
        .where('members', arrayContains: _authUser.currentUser!.uid)
        .get()
        .then((value) {
      return value.docs.map((doc) => Chat.fromJson(doc.data())).toList();
    });
  }
}
