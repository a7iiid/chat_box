import 'message.dart';

class Chat {
  List<String> members;
  List<Message>? messages;
  Chat({required this.members, this.messages});
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
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
