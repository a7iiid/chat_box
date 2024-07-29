import 'package:chat_app/provider/Home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/recent_message.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Provider.of<HomeProvider>(context)
                .pages[Provider.of<HomeProvider>(context).selectedPage],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              items: Provider.of<HomeProvider>(context).bottomItems,
              currentIndex: Provider.of<HomeProvider>(context).selectedPage,
              onTap: (index) {
                Provider.of<HomeProvider>(context, listen: false)
                    .onTapNav(index);
              },
              selectedItemColor: Color(0xFF24786D),
              unselectedItemColor: Color(0xFF797C7B),
              showSelectedLabels: true,
              showUnselectedLabels: true,
            ),
          );
        },
      ),
    );
  }
}
