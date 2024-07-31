import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatelessWidget {
  ChatBody({super.key});
  Duration duration = new Duration();
  Duration position = new Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Stack(
      children: [
        Consumer<ChatProvider>(builder: (context, chat, child) {
          List<Message>? messages = chat.chat?.messages;
          if (messages != null && messages.isNotEmpty) {
            return ListView.builder(
              // reverse: true,
              itemBuilder: (context, index) {
                bool tail = true;
                if (index < messages.length - 1 &&
                    messages[index].senderID == messages[index + 1].senderID) {
                  tail = false;
                }
                if (messages[index].senderID == user.uid) {
                  return BubbleSpecialThree(
                    text: messages[index].message,
                    color: Color(0xFF1B97F3),
                    tail: tail,
                    isSender: true,
                    textStyle:
                        AppStyle.messageText.copyWith(color: Colors.white),
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
        MessageBar(
          onSend: (value) {
            var chat = Provider.of<ChatProvider>(context, listen: false);
            var user = Provider.of<UserProvider>(context, listen: false);
            Message message = Message(
                message: value,
                type: 'text',
                senderID: FirebaseAuth.instance.currentUser!.uid,
                timestamp: Timestamp.now());
            chat.sendMessage(message, user.selectConversation!.chatId!);
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
