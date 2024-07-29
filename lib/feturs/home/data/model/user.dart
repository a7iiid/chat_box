import 'package:chat_app/feturs/home/data/model/conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String image;
  DateTime lastSeen;
  List<Conversation>? conversation;
  UserModel(
      {required this.name,
      required this.image,
      required this.lastSeen,
      this.conversation});
  factory UserModel.fromJson(Map<String, dynamic> json, List<Conversation> c) {
    return UserModel(
        image: json['image'],
        lastSeen: (json['lastSeen'] as Timestamp).toDate(),
        name: json['name'],
        conversation: c);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'lastSeen': lastSeen.toIso8601String(),
      'conversation': conversation,
    };
  }
}
