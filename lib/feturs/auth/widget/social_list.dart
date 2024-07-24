import 'package:chat_app/core/assets.dart';
import 'package:chat_app/feturs/auth/widget/social_login.dart';
import 'package:flutter/material.dart';

class SocialList extends StatelessWidget {
  const SocialList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialLogin(
          image: Assets.imageGooglePay,
        ),
        SocialLogin(
          image: Assets.imageFacebook,
        ),
        SocialLogin(
          image: Assets.imageApple,
        ),
      ],
    );
  }
}
