import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.imageLogo,
          color: Colors.white,
          height: 20,
        ),
        const SizedBox(
          width: 3,
        ),
        const Text(
          "ChatBox",
          style: AppStyle.regular14,
        )
      ],
    );
  }
}
