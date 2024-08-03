import 'package:chat_app/core/utils/splash_screen/splash.dart';
import 'package:chat_app/features/auth/auth_page.dart';
import 'package:chat_app/features/auth/login.dart';
import 'package:chat_app/features/auth/signup.dart';
import 'package:chat_app/features/chat/chat.dart';
import 'package:chat_app/features/home/Home.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';

abstract class Routes {
  static const kLoginScreen = '/signinscreen';
  static const kSignUpScreen = '/signupscreen';
  static const kHomePage = '/homepage';
  static const kAuthpage = '/authpage';
  static const kSettings = '/settings';
  static const kEditProfilePage = '/editProfile';
  static const kChat = '/chat';

  static final router = GoRouter(navigatorKey: navigatorKey, routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Splash();
      },
    ),
    GoRoute(
      path: kHomePage,
      builder: (context, state) {
        return const Home();
      },
    ),
    GoRoute(
      path: kLoginScreen,
      builder: (context, state) {
        return const Login();
      },
    ),
    GoRoute(
      path: kSignUpScreen,
      builder: (context, state) {
        return SignUp();
      },
    ),
    GoRoute(
      path: kAuthpage,
      builder: (context, state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      path: kChat,
      builder: (context, state) {
        return const Chat();
      },
    ),
  ]);
}
