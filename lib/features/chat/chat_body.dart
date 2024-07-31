import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatefulWidget {
  ChatBody({super.key});

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  Duration duration = Duration();
  Duration position = Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  User user = FirebaseAuth.instance.currentUser!;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<ChatProvider>(builder: (context, chat, child) {
                List<Message>? messages = chat.chat?.messages;
                if (messages != null && messages.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      bool tail = true;
                      if (index < messages.length - 1 &&
                          messages[index].senderID ==
                              messages[index + 1].senderID) {
                        tail = false;
                      }
                      if (messages[index].senderID == user.uid) {
                        return BubbleSpecialThree(
                          text: messages[index].message,
                          color: Color(0xFF1B97F3),
                          tail: tail,
                          isSender: true,
                          textStyle: AppStyle.messageText
                              .copyWith(color: Colors.white),
                        );
                      }
                      return BubbleSpecialThree(
                        text: messages[index].message,
                        textStyle: AppStyle.messageText,
                        color: Color(0xFFE8E8EE),
                        tail: tail,
                        isSender: false,
                      );
                    },
                    itemCount: messages.length,
                  );
                }
                return SizedBox();
              }),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
        MessageBar(
          onSend: (value) {
            var chat = Provider.of<ChatProvider>(context, listen: false);
            var user = Provider.of<UserProvider>(context, listen: false);
            Message message = Message(
                message: value,
                type: 'text',
                senderID: FirebaseAuth.instance.currentUser!.uid,
                timestamp: Timestamp.now());
            chat.sendMessage(
                message, user.selectConversation!.chatId!, context);
          },
          actions: [
            InkWell(
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 24,
              ),
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: InkWell(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                  size: 24,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
