import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
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
                if (messages[index].senderID ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return BubbleSpecialThree(
                    text: messages[index].message,
                    color: Color(0xFF1B97F3),
                    tail: false,
                    isSender: false,
                    textStyle:
                        AppStyle.messageText.copyWith(color: Colors.white),
                  );
                }
                return BubbleSpecialThree(
                  text: messages[index].message,
                  textStyle: AppStyle.messageText,
                  color: Color(0xFFE8E8EE),
                  tail: false,
                  isSender: false,
                );
              },
              itemCount: messages!.length,
            );
          }
          return SizedBox();
        }),
        MessageBar(
          onSend: (message) {},
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

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
