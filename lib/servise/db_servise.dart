import 'dart:developer';
import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Stream<List<UserModel>> streamAllUsersData() {
    return _db
        .collection(_userCollection)
        .snapshots()
        .asyncMap((userDocs) async {
      List<UserModel> users = [];

      for (var userDoc in userDocs.docs) {
        var conversationStream = _db
            .collection(_userCollection)
            .doc(userDoc.id)
            .collection(_chatCollection)
            .snapshots();

        var conversationDocs = await conversationStream.first;

        List<Conversation> conversations = conversationDocs.docs
            .map((doc) => Conversation.fromJson(doc.data(), doc.id))
            .toList();

        users.add(UserModel.fromJson(
            userDoc.data() as Map<String, dynamic>, conversations, userDoc.id));
      }

      return users;
    });
  }

  Stream<Chat?> streamChat(String chatId) {
    return _db.collection(_chatCollection).doc(chatId).snapshots().map(
        (querySnapshot) => Chat.fromJson(
            querySnapshot.data() as Map<String, dynamic>, querySnapshot.id));
  }

  Future<void> sendMessage(
      Message message, String chatId, BuildContext context) async {
    try {
      var selectConversation =
          Provider.of<UserProvider>(context, listen: false).selectConversation;

      await _db.collection(_chatCollection).doc(chatId).update({
        'messages': FieldValue.arrayUnion([message.toJson()])
      });

      var chat = Provider.of<ChatProvider>(context, listen: false).selectChat;
      for (String member in chat!.members) {
        if (member != _authUser.currentUser!.uid) {
          bool exists = await conversationExists(member, chatId);
          if (!exists) {
            await createConversation(
                Conversation(
                    id: selectConversation!.id,
                    chatId: selectConversation.chatId,
                    image: selectConversation.image,
                    lastMessage: message.message,
                    name: selectConversation.name,
                    receiverId: _authUser.currentUser!.uid,
                    timestamp: message.timestamp),
                member);
          }
        }
      }

      selectConversation = Conversation(
          id: selectConversation!.id,
          chatId: selectConversation.chatId,
          image: selectConversation.image,
          lastMessage: message.message,
          name: selectConversation.name,
          receiverId: selectConversation.receiverId,
          timestamp: message.timestamp);

      await updateConversation(selectConversation);
      await updateLastMessageInConversation(
          chatId, message.message, message.timestamp);
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<Conversation>> streamUserConversations(String userId) {
    return _db
        .collection(_userCollection)
        .doc(userId)
        .collection(_chatCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Conversation.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> updateLastMessageInConversation(
      String chatId, String lastMessage, Timestamp timestamp) async {
    try {
      var chat = await _db.collection(_chatCollection).doc(chatId).get();
      if (chat.exists) {
        var members = List<String>.from(chat.data()!['members']);
        for (var member in members) {
          var conversationSnapshot = await _db
              .collection(_userCollection)
              .doc(member)
              .collection(_chatCollection)
              .where('chatId', isEqualTo: chatId)
              .get();

          if (conversationSnapshot.docs.isNotEmpty) {
            var conversationDoc = conversationSnapshot.docs.first;
            await conversationDoc.reference.update({
              'lastMessage': lastMessage,
              'timestamp': timestamp,
            });
          }
        }
      }
    } catch (e) {
      log('Failed to update last message in conversation: $e');
    }
  }

  Future<void> updateConversation(Conversation conversation) async {
    try {
      await _db
          .collection(_userCollection)
          .doc(_authUser.currentUser!.uid)
          .collection(_chatCollection)
          .doc(conversation.id)
          .update(conversation.toJson());
    } catch (e) {
      log('Failed to update conversation: $e');
    }
  }

  Future<Conversation?> createChat(
      UserModel receiver, UserModel sender, BuildContext context) async {
    Chat chat = Chat(members: [receiver.id, sender.id]);

    try {
      var response = await _db.collection(_chatCollection).add(chat.toJson());
      chat.id = response.id;
      Provider.of<ChatProvider>(context, listen: false).loadChatUser(chat.id!);

      Conversation conversation = Conversation(
          chatId: chat.id,
          image: receiver.image,
          lastMessage: '',
          receiverId: receiver.id,
          name: receiver.name,
          timestamp: Timestamp.now());

      return await createConversation(conversation, _authUser.currentUser!.uid);
    } catch (_) {
      log('Failed to create chat');
    }
  }

  Future<bool> conversationExists(String uid, String chatId) async {
    var snapshot = await _db
        .collection(_userCollection)
        .doc(uid)
        .collection(_chatCollection)
        .where('chatId', isEqualTo: chatId)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<Conversation?> createConversation(
      Conversation conversation, String uid) async {
    try {
      var response = await _db
          .collection(_userCollection)
          .doc(uid)
          .collection(_chatCollection)
          .add(conversation.toJson());
      conversation.id = response.id;
      return conversation;
    } catch (e) {
      log('Failed to create conversation: $e');
    }
  }
}
