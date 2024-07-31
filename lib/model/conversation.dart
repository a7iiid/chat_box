import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String id;
  String? chatId;
  String? name;
  String? image;
  String? lastMessage;
  Timestamp? timestamp;

  Conversation({
    required this.id,
    this.chatId,
    this.name,
    this.image,
    this.lastMessage,
    this.timestamp,
  });

  factory Conversation.fromJson(Map<String, dynamic> json, String ID) {
    return Conversation(
      id: ID,
      chatId: json['chatId'],
      name: json['name'],
      image: json['image'],
      lastMessage: json['lastMessage'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'name': name,
      'image': image,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
    };
  }
}
