import 'dart:async';
import 'dart:developer';

import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/user.dart';
import 'package:chat_app/provider/user_provider.dart';
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
  sendingMessage,
  errorSendMessage,
}

class ChatProvider with ChangeNotifier {
  static ChatProvider get(BuildContext context) =>
      Provider.of<ChatProvider>(context);

  Chat? selectChat;
  ChatStatus status = ChatStatus.loadingMessages;
  late StreamSubscription<Chat?> _chatSubscription;

  Future<void> loadChatUser(String chatId) async {
    status = ChatStatus.successLoadConversation;
    notifyListeners();

    try {
      _chatSubscription =
          DbService.instance.streamChat(chatId).listen((fetchedChat) {
        selectChat = fetchedChat;
        if (selectChat != null &&
            selectChat!.messages != null &&
            selectChat!.messages!.isNotEmpty) {
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

  Future<void> sendMessage(
      Message message, String chatId, BuildContext context) async {
    status = ChatStatus.sendingMessage;
    notifyListeners();
    try {
      await DbService.instance.sendMessage(message, chatId, context);
      status = ChatStatus.sendMessage;
    } catch (e) {
      status = ChatStatus.errorSendMessage;
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> createChat(
      UserModel receiver, UserModel sender, BuildContext context) async {
    status = ChatStatus.successLoadConversation;
    notifyListeners();
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.selectConversation =
        await DbService.instance.createChat(receiver, sender, context);
  }

  @override
  void dispose() {
    _chatSubscription.cancel();
    super.dispose();
  }
}
