import 'message.dart';

class Chat {
  String? id;
  List<String> members;
  List<Message>? messages;
  Chat({required this.members, this.messages, this.id});
  factory Chat.fromJson(Map<String, dynamic> json, String id) {
    return Chat(
      id: id,
      members: json['members'].cast<String>(),
      messages: (json['messages'] as List<dynamic>)
          .map((messageJson) => Message.fromJson(messageJson))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'members': members,
      'messages': messages?.map((message) => message.toJson()).toList(),
    };
  }
}
