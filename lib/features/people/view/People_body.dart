import 'package:chat_app/features/home/widget/main_shap.dart';
import 'package:flutter/material.dart';

import '../../home/widget/LastMessages.dart';
import '../../home/widget/hedar_home.dart';

class PeopleBody extends StatelessWidget {
  const PeopleBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * .9;
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
          top: MediaQuery.of(context).size.height * 0.2,
          child: MainShap(height: height, child: PeopleCard()),
        ),
      ],
    );
    ;
  }
}

class PeopleCard extends StatelessWidget {
  const PeopleCard({
    super.key,
  });

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
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              radius: 60,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hello',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
