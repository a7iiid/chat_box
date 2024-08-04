import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  String senderID;
  Timestamp timestamp;
  String type;
  MessageModel(
      {required this.message,
      required this.senderID,
      required this.timestamp,
      required this.type});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      senderID: json['senderID'],
      timestamp: json['timestamp'] as Timestamp,
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderID': senderID,
      'timestamp': timestamp,
      'type': type
    };
  }
}
