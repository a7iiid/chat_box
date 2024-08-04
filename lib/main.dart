import 'dart:convert';

import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'core/utils/router/routs.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void showNotification(Map<String, dynamic>? data) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'message_channel_id',
    'Message Notifications',
    channelDescription: 'Notification channel for message notifications',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'New Message',
    'You have a new message in ${data?['name'] ?? 'a conversation'}',
    platformChannelSpecifics,
    payload: 'message_payload',
  );
}

void setupFirestoreListener(String userId) {
  FirebaseFirestore.instance
      .collection('conversation')
      .where('members', arrayContains: userId)
      .snapshots()
      .listen((snapshot) {
    for (var change in snapshot.docChanges) {
      if (change.type == DocumentChangeType.added ||
          change.type == DocumentChangeType.modified) {
        var conversationData = Chat.fromJson(
            change.doc.data() as Map<String, dynamic>, change.doc.id);

        if (conversationData.messages!.last.senderID != userId) {
          showNotification(change.doc.data());
        }
      }
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // call the useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider())
      ],
      child: MyApp(navigatorKey: navigatorKey),
    ));
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.navigatorKey});
  final GlobalKey navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
      title: "ChatBox",
    );
  }
}
