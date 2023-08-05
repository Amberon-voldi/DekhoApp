import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/models/ChatContainer.dart';
import 'package:dekho/models/Message.dart';

import '../../models/User.dart';

class ChatModel {
  String? name;
  User? userData;
  dynamic time;
  List? members;
  String? lastMessage;
  dynamic? lastMessageTime;
  ChatContainer? container;

  String? icon;

  ChatModel(
      {this.name,
      this.time,
      this.icon,
      required this.members,
      this.lastMessage,
      this.lastMessageTime,
      this.userData,
      this.container});

  ChatModel.fromJson(Map<String, dynamic> json, User user, ChatContainer jk) {
    name = user.name ?? ' ';
    members = json['members'];
    time = json['startTime'];
    userData = user;
    container = jk;
    lastMessageTime = json['lastMessageTime'];

    lastMessage = json['lastMessage'];
    icon = user.pfp;
  }
}
