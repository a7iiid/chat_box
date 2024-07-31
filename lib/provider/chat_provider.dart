import 'package:chat_app/model/chat.dart'; // Use the correct import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../servise/db_servise.dart';

enum ChatStatus {
  loadingMessages,
  successLoadMessage,
  successLoadConversation,
  successLoadUser,
  successLoadUserConversation,
  successLoadUserMessage,
  errorLoadUserMessage,
}

class ChatProvider with ChangeNotifier {
  static ChatProvider get(context) => Provider.of<ChatProvider>(context);

  Chat? chat;
  ChatStatus status = ChatStatus.loadingMessages;

  Future<void> loadChatUser(String chatId) async {
    status = ChatStatus.successLoadConversation;
    notifyListeners();
    try {
      chat = await DbService.instance.loadChatUser(chatId);
      status = ChatStatus.successLoadMessage;
    } catch (_) {
      status = ChatStatus.errorLoadUserMessage;
    }
    notifyListeners();
  }
}
