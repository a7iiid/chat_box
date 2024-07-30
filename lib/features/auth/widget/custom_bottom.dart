import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key, required this.func, required this.text});

  final String text;
  final Function()? func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        height: 48,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xff24786D)),
        child: Center(
          child: Text(
            text,
            style: AppStyle.bold16,
          ),
        ),
      ),
    );
  }
}
