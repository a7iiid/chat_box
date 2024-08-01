import 'dart:async';

import 'package:chat_app/core/assets.dart';
import 'package:chat_app/core/utils/app_style.dart';
import 'package:chat_app/core/utils/router/routs.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCirc,
  );
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Provider.of<UserProvider>(context, listen: false).loadAllUserData();
      });
    }

    navPage(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.imageLogo,
            ),
            const SizedBox(
              height: 13,
            ),
            const Text(
              "Chatbox",
              style: AppStyle.Bolde40,
            )
          ],
        ),
      ),
    );
  }
}

void navPage(BuildContext context) {
  Future.delayed(const Duration(seconds: 3), () async {
    if (FirebaseAuth.instance.currentUser == null) {
      GoRouter.of(context).pushReplacement(Routes.kAuthpage);
    } else {
      GoRouter.of(context).pushReplacement(Routes.kHomePage);
    }
  });
}
