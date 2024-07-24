import 'package:chat_app/core/utils/splash_screen/splash.dart';
import 'package:flutter/material.dart';

import 'core/utils/router/routs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router,
      title: "ChatBox",
    );
  }
}
