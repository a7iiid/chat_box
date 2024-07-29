import 'package:chat_app/feturs/home/data/model/conversation.dart';
import 'package:chat_app/feturs/home/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/assets.dart';
import '../../../core/utils/app_style.dart';
import '../../../provider/user_provider.dart';

class LastMessages extends StatefulWidget {
  const LastMessages({super.key});

  @override
  _LastMessagesState createState() => _LastMessagesState();
}

class _LastMessagesState extends State<LastMessages> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Conversation>? conversation;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    conversation = UserProvider.get(context).user?.conversation;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // Use the userProvider instance here
  }

  void _removeItem(int index) {
    Conversation removedMessage = conversation!.removeAt(index);
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
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Add padding
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
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7, // Constrain height
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding
        child: Builder(builder: (context) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: conversation!.length,
            itemBuilder: (context, index, animation) {
              return Slidable(
                key: ValueKey(conversation?[index]),
                direction: Axis.horizontal,
                endActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),
                  dragDismissible: true,

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
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
                child: _buildItem(conversation![index], animation),
              );
            },
          );
        }),
      ),
    );
  }
}
