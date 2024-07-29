import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String? chatId;
  String? image;
  String? lastMessage;
  String? name;
  Timestamp? timestamp;
  int? unseenCount;

  Conversation(
      {this.chatId,
      this.image,
      this.lastMessage,
      this.name,
      this.timestamp,
      this.unseenCount});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      chatId: json['chatId'],
      image: json['image'],
      lastMessage: json['lastMessage'],
      name: json['name'],
      timestamp: json['timestamp'] as Timestamp,
      unseenCount: json['unseenCount'],
    );
  }
}
