import 'package:chat_app/core/assets.dart';
import 'package:chat_app/features/chat/chat_body.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(Provider.of<UserProvider>(context, listen: false)
            .selectConversation!
            .name!),
        actions: [
          ZegoSendCallInvitationButton(
            onPressed: (code, message, p2) {
              print("Call invitation sent to: ${p2.map((e) => e).join(", ")}");
            },
            isVideoCall: false,
            iconSize: Size(30, 30),
            margin: EdgeInsets.all(0),
            icon: ButtonIcon(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(Assets.imageCallMessage)),
            //You need to use the resourceID that you created in the subsequent steps.
            //Please continue reading this document.
            resourceID: "ChatBox",
            invitees: [
              ZegoUIKitUser(
                id: Provider.of<UserProvider>(context, listen: false)
                    .selectConversation!
                    .receiverId!,
                name: Provider.of<UserProvider>(context, listen: false)
                    .selectConversation!
                    .name!,
              ),
            ],
          ),
          //   ZegoSendCallInvitationButton(
          //     isVideoCall: true,
          //     iconSize: Size(30, 30),

          //     icon: ButtonIcon(
          //         backgroundColor: Colors.white,
          //         icon: SvgPicture.asset(Assets.imageVideo)),
          //     //You need to use the resourceID that you created in the subsequent steps.
          //     //Please continue reading this document.
          //     resourceID: "ChatBox",
          //     invitees: [
          //       ZegoUIKitUser(
          //         id: Provider.of<UserProvider>(context, listen: false)
          //             .selectConversation!
          //             .receiverId!,
          //         name: Provider.of<UserProvider>(context, listen: false)
          //             .selectConversation!
          //             .name!,
          //       ),
          //     ],
          //   ),
        ],
      ),
      body: ChatBody(),
    );
  }
}
