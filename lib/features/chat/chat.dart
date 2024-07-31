import 'package:chat_app/features/chat/chat_body.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Provider.of<UserProvider>(context, listen: false)
            .selectConversation!
            .name!),
      ),
      body: ChatBody(),
    );
  }
}
