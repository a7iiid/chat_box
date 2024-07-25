import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/feturs/auth/widget/form_login.dart';
import 'package:chat_app/feturs/auth/widget/social_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widget/deviders.dart';
import 'widget/social_login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 41.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 110,
                    ),
                    Text(
                      'Log in to Chatbox',
                      style: AppStyle.bold18,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '''Welcome back! Sign in using your social account or email to continue us''',
                      style: AppStyle.scondaryText,
                      textAlign: TextAlign.center, // Ensure text is centered
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    InkWell(
                      child: SocialList(),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Deviders(),
                    SizedBox(
                      height: 36,
                    ),
                  ],
                ),
              ),
              FormLogin()
            ],
          )),
    );
  }
}
