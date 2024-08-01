import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/router/routs.dart';
import '../../../model/conversation.dart';
import '../../../provider/chat_provider.dart';
import '../../../provider/user_provider.dart';
import '../../home/widget/hedar_home.dart';
import '../../home/widget/main_shap.dart';
import '../widget/people_card.dart';

class PeopleBody extends StatelessWidget {
  const PeopleBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * .9;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 50,
          child: const HedarHome(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          child: MainShap(
            height: height,
            child: Consumer<UserProvider>(
              builder: (context, provider, child) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                  ),
                  itemCount: provider.users!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        provider.selectUser = provider.users![index];
                        bool haveChat = false;

                        // Check if conversation exists
                        if (provider.user!.conversation != null) {
                          for (Conversation conversation
                              in provider.user!.conversation!) {
                            if (conversation.receiverId ==
                                provider.selectUser!.id) {
                              provider.selectConversation = conversation;
                              Provider.of<ChatProvider>(context, listen: false)
                                  .loadChatUser(conversation.chatId!);
                              haveChat = true;
                              break;
                            }
                          }
                        }

                        // If no chat exists, create a new one
                        if (!haveChat) {
                          await Provider.of<ChatProvider>(context,
                                  listen: false)
                              .createChat(provider.selectUser!, provider.user!,
                                  context);
                        }

                        // Navigate to chat page
                        GoRouter.of(context).push(Routes.kChat);
                      },
                      child: PeopleCard(
                        user: provider.users![index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
