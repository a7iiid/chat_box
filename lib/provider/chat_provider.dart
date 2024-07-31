import 'dart:async';

import 'package:chat_app/model/message.dart';
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
      DbService.instance.sendMessage(message, chatId, context);
    } catch (e) {
      status = ChatStatus.errorSendMessage;
    }
    notifyListeners();
  }

  // Future<void> checkChat(String receiverId) async {
  //   status = ChatStatus.successLoadConversation;
  //   notifyListeners();

  //   try {
  //     final chat = await DbService.instance.getChat(receiverId);
  //     if (chat!.id != null) {
  //       _chatSubscription =
  //           DbService.instance.streamChat(chat.id!).listen((fetchedChat) {
  //         selectChat = fetchedChat;
  //         if (selectChat != null &&
  //             selectChat!.messages != null &&
  //             selectChat!.messages!.isNotEmpty) {
  //           status = ChatStatus.successLoadMessage;
  //         } else {
  //           status = ChatStatus.isEmptyMessages;
  //         }
  //         notifyListeners();
  //       });
  //     }
  //   } catch (_) {
  //     status = ChatStatus.errorLoadUserMessage;
  //     notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    _chatSubscription.cancel();
    super.dispose();
  }
}
