import 'package:chat_app/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLogin extends StatelessWidget {
  SocialLogin({super.key, required this.image, this.color = Colors.white});
  Widget image;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: 48,
        height: 48,
        decoration: ShapeDecoration(
          color: color,
          shape: OvalBorder(
            side: BorderSide(
                width: 1,
                color:
                    color == Colors.white ? Color(0xFF000D07) : Colors.white),
          ),
        ),
        child: image);
  }
}
