import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/model/user.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  PeopleCard({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              radius: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(user.name,
                style: AppStyle.bold16.copyWith(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
