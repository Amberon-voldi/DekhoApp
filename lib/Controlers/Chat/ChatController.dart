import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Controlers/Chat/ChatModel.dart';
import 'package:dekho/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Utils/variables.dart';
import '../../models/ChatContainer.dart';
import '../../models/Message.dart';
import '../../models/User.dart';

class ChatController {
  RxList chatlist = [].obs;
  ChatController() {
    getChatList();
  }

  getChatList() async {
    Get.log(userid + 'chatlist');

    try {
      final request = ModelQueries.list(
        ChatContainer.classType,
        where: ChatContainer.MEMBERS.contains(userid),
      );
      final response = await Amplify.API.query(request: request).response;
      Get.log(response.data!.items.toString() + 'chatlist');

      final items = response.data!.items ?? [];

      if (items.isNotEmpty || items.any((element) => element == null)) {
        items.forEach((element) async {
          final mem = element!.members;

          if (mem.isEmpty) {
            return;
          }
          final otherid = mem[0];
          final request = ModelQueries.get(
            User.classType,
            otherid,
          );
          final km = ModelQueries.list(Message.classType,
              where: Message.CHATCONTAINERID.eq(element.id));
          final re = await Amplify.API.query(request: km).response;
          Get.log(re.data.toString() + 'chatlist');
          if (re.data!.items!.isNotEmpty) {
            final box = GetStorage();
            box.write(element.id, re.data!.items);
          }
          final response = await Amplify.API.query(request: request).response;
          final user = response.data;
          if (user != null) {
            ChatModel chat =
                ChatModel.fromJson(element.toJson(), user, element);
            if (chatlist.any(
                (element) => element.container!.id == chat.container!.id)) {
              return;
            }
            chatlist.add(chat);
            Get.log(chat.toString());
          }
        });

        Get.log(chatlist.toString() + 'chatlist updated');
      }
    } catch (e) {
      Get.log(e.toString());
    }
  }
}
