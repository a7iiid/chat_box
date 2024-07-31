import 'package:flutter/material.dart';
import '../widget/LastMessages.dart';
import '../widget/hedar_home.dart';
import '../widget/status.dart';

class RecantMessages extends StatelessWidget {
  const RecantMessages({super.key});

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
          bottom: MediaQuery.of(context).size.height * 0.6,
          child: const Status(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7, // Constrain height
          child: const LastMessages(),
        ),
      ],
    );
  }
}
