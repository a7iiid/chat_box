import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 29,
                ),
                const SizedBox(height: 16),
                Text(
                  "Ahmad",
                  style: AppStyle.regular14,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
