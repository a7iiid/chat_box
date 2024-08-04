import 'package:chat_app/main.dart';
import 'package:chat_app/servise/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/Home_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    setupFirestoreListener(userId);
    AuthUser.onUserLogin();
  }

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
