import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/feturs/auth/widget/social_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widget/social_login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 41.0),
        child: SingleChildScrollView(
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
                '''Welcome back! Sign in using your social account
                 or email to continue us''',
                style: AppStyle.scondaryText,
                maxLines: 2,
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
              Deviders()
            ],
          ),
        ),
      ),
    );
  }
}

class Deviders extends StatelessWidget {
  const Deviders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Line(),
        Text(
          "OR",
          style: AppStyle.scondaryText,
        ),
        Line(),
      ],
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.50,
      child: Container(
        width: 132,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color(0xFFCDD1D0),
            ),
          ),
        ),
      ),
    );
  }
}
