import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/feturs/auth/widget/form_log_up.dart';
import 'package:chat_app/feturs/auth/widget/social_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../servise/media_servise.dart';
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
