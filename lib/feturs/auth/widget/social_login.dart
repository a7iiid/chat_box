import 'package:chat_app/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLogin extends StatelessWidget {
  SocialLogin({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 48,
        height: 48,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(
            side: BorderSide(width: 1, color: Color(0xFF000D07)),
          ),
        ),
        child: SvgPicture.asset(image));
  }
}
