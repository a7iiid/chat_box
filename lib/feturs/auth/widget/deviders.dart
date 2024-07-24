import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/feturs/auth/login.dart';
import 'package:flutter/material.dart';

import 'line.dart';

class Deviders extends StatelessWidget {
  const Deviders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Line(),
        Text(
          "OR",
          style: AppStyle.scondaryText,
        ),
        Line(),
      ],
    );
  }
}
