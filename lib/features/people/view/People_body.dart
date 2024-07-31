import 'package:chat_app/features/home/widget/main_shap.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/widget/LastMessages.dart';
import '../../home/widget/hedar_home.dart';
import '../widget/people_card.dart';

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
          child: MainShap(
              height: height,
              child: Consumer<UserProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                    ),
                    itemCount: provider.users!.length,
                    itemBuilder: (context, index) {
                      return PeopleCard(
                        user: provider.users![index],
                      );
                    },
                  );
                },
              )),
        ),
      ],
    );
    ;
  }
}
