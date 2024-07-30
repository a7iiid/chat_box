import 'package:chat_app/core/assets.dart';
import 'package:chat_app/features/auth/widget/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialList extends StatelessWidget {
  SocialList(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.spaceAround,
      this.color = Colors.white});
  MainAxisAlignment mainAxisAlignment;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SocialLogin(
          image: SvgPicture.asset(Assets.imageGooglePay),
          color: color,
        ),
        SocialLogin(
          image: SvgPicture.asset(Assets.imageFacebook),
          color: color,
        ),
      ],
    );
  }
}
