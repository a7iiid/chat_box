import 'package:chat_app/features/home/widget/custom_container.dart';
import 'package:flutter/material.dart';

class MainShap extends StatelessWidget {
  MainShap({super.key, required this.child, this.height});
  Widget child;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.7,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(),
            Expanded(child: child),
          ],
        ));
  }
}
