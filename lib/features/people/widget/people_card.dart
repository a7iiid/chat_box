import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/model/user.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class PeopleCard extends StatelessWidget {
  PeopleCard({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 2.5 / 3,
        child: Container(
          height: MediaQuery.sizeOf(context).width * .48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Image.network(
                      user.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
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
            ],
          ),
        ),
      ),
    );
  }
}
