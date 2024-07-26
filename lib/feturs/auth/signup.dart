import 'dart:io';
import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/feturs/auth/widget/form_log_up.dart';
import 'package:chat_app/feturs/auth/widget/social_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../servise/media_servise.dart';
import 'widget/deviders.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MediaService(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 110),
                    const Text('Sign up with Email', style: AppStyle.bold18),
                    const SizedBox(height: 20),
                    const Text(
                      'Get chatting with friends and family today by signing up for our chat app!',
                      style: AppStyle.scondaryText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 38),
                    SocialList(),
                    const SizedBox(height: 36),
                    const Deviders(),
                    const SizedBox(height: 36),
                    Consumer<MediaService>(
                      builder: (context, mediaService, child) => Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async {
                            await mediaService.getImageFromLibrary();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.height * 0.10,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(500),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: mediaService.image != null
                                    ? FileImage(mediaService.image!)
                                    : const NetworkImage(
                                        "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png",
                                      ) as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const FormLogup(),
            ],
          ),
        ),
      ),
    );
  }
}
