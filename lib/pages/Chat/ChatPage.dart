import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekho/Controlers/Chat/ChatModel.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/main.dart';
import 'package:dekho/models/Message.dart';
import 'package:dekho/models/MessageStatus.dart';
import 'package:dekho/pages/Chat/MessageScreen.dart';
import 'package:dekho/widgets/notSignedin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../Controlers/Chat/ChatController.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final title = 'chatController.chatlist';
  final chatController = GetIt.instance<ChatController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getd();
  }

  getd() async {
    try {
      if (isSignedin) {
        await chatController.getChatList();
        if (mounted) {
          setState(() {});
        }
      }

      Get.log(chatController.chatlist.first.lastMessage.toString());
    } catch (e) {
      Get.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isSignedin
        ? NotSignedIn()
        : Obx((() => Scaffold(
              backgroundColor: Colors.black,
              body: chatController.chatlist.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            UniconsLine.chat,
                            size: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'No Chat',
                            style: GoogleFonts.dmSans(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: chatController.chatlist.length,
                      itemBuilder: (context, index) {
                        final box = GetStorage();
                        List<Message?> messaes = box.read(
                                chatController.chatlist[index].container.id) ??
                            [];
                        final jj = messaes
                            .where((element) =>
                                element!.messageStatus != MessageStatus.SEEN &&
                                element.userID != userid)
                            .toList();
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(
                                chatController.chatlist[index].icon ?? ' '),
                          ),
                          title: Text(
                            chatController.chatlist[index].name,
                            style: GoogleFonts.dmSans(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            chatController.chatlist[index].lastMessage ?? ' ',
                            style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Get.to(() => MessageScreen(
                                  container: chatController.chatlist[index],
                                ));
                          },
                          trailing: Column(
                            children: [
                              chatController.chatlist[index].lastMessageTime ==
                                      null
                                  ? Text(
                                      TemporalDateTime.fromString(chatController
                                                  .chatlist[index].time!)
                                              .getDateTimeInUtc()
                                              .hour
                                              .toString() +
                                          ':' +
                                          TemporalDateTime.fromString(
                                                  chatController
                                                      .chatlist[index].time!)
                                              .getDateTimeInUtc()
                                              .minute
                                              .toString(),
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 98, 95, 95),
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      TemporalDateTime.fromString(chatController
                                                  .chatlist[index]
                                                  .lastMessageTime
                                                  .toString())
                                              .getDateTimeInUtc()
                                              .hour
                                              .toString() +
                                          ':' +
                                          TemporalDateTime.fromString(
                                                  chatController.chatlist[index]
                                                      .lastMessageTime
                                                      .toString())
                                              .getDateTimeInUtc()
                                              .minute
                                              .toString(),
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 98, 95, 95),
                                          fontWeight: FontWeight.bold),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (jj.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    jj.length.toString(),
                                    style: GoogleFonts.dmSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                            ],
                          ),
                        );
                      }),
            )));
  }
}
