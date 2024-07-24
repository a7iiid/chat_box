import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HedarHome extends StatelessWidget {
  const HedarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const ShapeDecoration(
            shape: OvalBorder(
              side: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
          child: IconButton(
            icon: SvgPicture.asset(Assets.imageSearch),
            onPressed: () {},
          ),
        ),
        Text(
          "Home",
          style: AppStyle.medium20.copyWith(color: Colors.white),
        ),
        CircleAvatar(
          radius: 22,
        )
      ],
    );
  }
}
