import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

import '../widget/hedar_home.dart';
import '../widget/status.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 50,
          child: const HedarHome(),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 130,
          bottom: 0,
          child: const Status(),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
