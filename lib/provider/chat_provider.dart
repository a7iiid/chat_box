import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/model/chat.dart';
import '../servise/db_servise.dart';

enum ChatStatus {
  loadingMessages,
  successLoadMessage,
  successLoadConversation,
  successLoadUser,
  successLoadUserConversation,
  successLoadUserMessage,
  errorLoadUserMessage,
  isEmptyMessages,
  sendMessage,
  errorSendMessage,
}

class ChatProvider with ChangeNotifier {
  static ChatProvider get(BuildContext context) =>
      Provider.of<ChatProvider>(context);

  Chat? chat;
  ChatStatus status = ChatStatus.loadingMessages;
  late StreamSubscription<Chat?> _chatSubscription;

  Future<void> loadChatUser(String chatId) async {
    status = ChatStatus.successLoadConversation;
    notifyListeners();

    try {
      _chatSubscription =
          DbService.instance.streamChat(chatId).listen((fetchedChat) {
        chat = fetchedChat;
        if (chat != null &&
            chat!.messages != null &&
            chat!.messages!.isNotEmpty) {
          status = ChatStatus.successLoadMessage;
        } else {
          status = ChatStatus.isEmptyMessages;
        }
        notifyListeners();
      });
    } catch (_) {
      status = ChatStatus.errorLoadUserMessage;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String message) {}
  @override
  void dispose() {
    _chatSubscription.cancel();
    super.dispose();
  }
}
