import 'dart:developer';
import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbService {
  static final DbService instance = DbService();
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final FirebaseAuth _authUser;
  final String _userCollection = 'users';
  final String _chatCollection = 'conversation';

  DbService()
      : _db = FirebaseFirestore.instance,
        _authUser = FirebaseAuth.instance,
        _storage = FirebaseStorage.instance;

  Future<void> createUserDb(
      String name, String email, String uid, String image) async {
    await _db.collection(_userCollection).doc(uid).set({
      'name': name,
      'email': email,
      'image': image,
      'lastSeen': DateTime.now().toUtc(),
    });
  }

  Future<UserModel> loadUserData() async {
    var userDoc = await _db
        .collection(_userCollection)
        .doc(_authUser.currentUser!.uid)
        .get();
    var conversationDocs = await _db
        .collection(_userCollection)
        .doc(_authUser.currentUser!.uid)
        .collection(_chatCollection)
        .get();

    List<Conversation> conversations = conversationDocs.docs
        .map((doc) => Conversation.fromJson(doc.data()))
        .toList();

    return UserModel.fromJson(
        userDoc.data() as Map<String, dynamic>, conversations);
  }

  Stream<Chat?> streamChat(String chatId) {
    return _db.collection(_chatCollection).doc(chatId).snapshots().map(
        (querySnapshot) =>
            Chat.fromJson(querySnapshot.data() as Map<String, dynamic>));
  }

  Future<void> sendMessage(Message message, String chatId) async {
    try {
      await _db.collection(_chatCollection).doc(chatId).update({
        'messages': FieldValue.arrayUnion([message.toJson()])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateConversation(Conversation conversation) async {
    try {
      await _db
          .collection(_userCollection)
          .doc(_authUser.currentUser!.uid)
          .collection(_chatCollection)
          .doc(conversation.chatId)
          .update(conversation.toJson());
    } catch (e) {
      log('Failed to update conversation: $e');
    }
  }
}
