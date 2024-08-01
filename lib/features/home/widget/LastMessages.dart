import 'package:chat_app/core/utils/router/routs.dart';
import 'package:chat_app/model/conversation.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/assets.dart';
import '../../../core/utils/app_style.dart';
import '../../../provider/user_provider.dart';
import 'main_shap.dart';

class LastMessages extends StatefulWidget {
  const LastMessages({super.key});

  @override
  _LastMessagesState createState() => _LastMessagesState();
}

class _LastMessagesState extends State<LastMessages> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .streamUserConversations();
    });
  }

  void _removeItem(int index) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Conversation removedMessage =
        userProvider.user!.conversation!.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildItem(removedMessage, animation),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildItem(Conversation conversation, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(conversation.image!),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.name!,
                  style: AppStyle.medium20,
                ),
                Text(
                  conversation.lastMessage!,
                  style: AppStyle.meduim12,
                ),
              ],
            ),
            const Spacer(),
            Text(
              conversation.timestamp!.toDate().toString(),
              style: AppStyle.meduim12,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainShap(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final conversation = userProvider.user?.conversation;
            if (userProvider.userStat == UserStat.loadingUser ||
                conversation == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return AnimatedList(
              key: _listKey,
              initialItemCount: conversation.length,
              itemBuilder: (context, index, animation) {
                return InkWell(
                  onTap: () {
                    userProvider.selectConversation = conversation[index];
                    Provider.of<ChatProvider>(context, listen: false)
                        .loadChatUser(conversation[index].chatId!);
                    GoRouter.of(context).push(Routes.kChat);
                  },
                  child: Slidable(
                    key: ValueKey(conversation[index]),
                    direction: Axis.horizontal,
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dragDismissible: true,
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: SvgPicture.asset(Assets.imageNotification),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _removeItem(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: SvgPicture.asset(Assets.imageTrash),
                            ),
                          ),
                        )
                      ],
                    ),
                    child: _buildItem(conversation[index], animation),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
