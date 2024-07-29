import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String image;
  DateTime lastSeen;
  List<String>? conversation;
  UserModel(
      {required this.name,
      required this.image,
      required this.lastSeen,
      this.conversation});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json['image'],
      lastSeen: (json['lastSeen'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      name: json['name'],
      conversation: json['conversation'],
    );
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
