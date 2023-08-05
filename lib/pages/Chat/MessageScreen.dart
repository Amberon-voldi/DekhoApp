import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_api/model_subscriptions.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dekho/Controlers/Chat/ChatModel.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/Message.dart';
import 'package:dekho/models/MessageStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as g;
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/ChatContainer.dart';

class MessageScreen extends StatefulWidget {
  ChatModel container;
  MessageScreen({super.key, required this.container});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

final Updatelist = false.obs;

class _MessageScreenState extends State<MessageScreen> {
  g.RxList<Message> messages = <Message>[].obs;
  TextEditingController messageController = TextEditingController();

  StreamSubscription<GraphQLResponse<Message>>? Createsubscription;
  g.RxBool isloading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getMessenges();
      Createsubscribe();
      Deletesubscribe();
      g.Get.log('Init');
    });
  }

  golastmessage() async {
    final box = GetStorage();
    box.write(widget.container.container!.id.toString(), messages);

    List<Message> sentmessages =
        messages.where((p0) => p0.messageStatus == MessageStatus.SENT).toList();
    box.write(widget.container.container!.id.toString(), sentmessages);
    if (messages.isNotEmpty &&
        messages.last.message != widget.container.lastMessage) {
      widget.container.lastMessage = messages.last.message!;
      widget.container.lastMessageTime = messages.last.createdAt;
      g.Get.log('Last Message');
      final request =
          ModelMutations.update(widget.container.container!.copyWith(
        lastMessage: messages.last.message,
        lastMessageTime: messages.last.createdAt,
      ));

      final reponse = await Amplify.API.mutate(request: request).response;
      g.Get.log(reponse.data.toString());
    }
  }

  @override
  void dispose() {
    golastmessage();
    try {
      Createsubscription!.cancel();
      Deletesubscription!.cancel();
    } catch (e) {
      g.Get.log(e.toString());
    }

    g.Get.log('Disposed');
    super.dispose();
  }

  getMessenges() async {
    isloading.value = true;
    // final box = GetStorage();
    // try {
    //   if (box.hasData(widget.container.container!.id.toString())) {
    //     List hh = box.read(widget.container.container!.id.toString());
    //     g.Get.log(hh.toString());
    //     hh.forEach((element) {
    //       Message meage = Message.fromJson(element.toJson());
    //       messages.add(meage);
    //     });

    //     isloading.value = false;
    //     g.Get.log('From Box');
    //     return; // if data is already present in the box
    //   }
    // } catch (e) {
    //   g.Get.log(e.toString());
    // }

    try {
      final response = await Amplify.API
          .query(
            request: ModelQueries.list(Message.classType,
                where:
                    Message.CHATCONTAINERID.eq(widget.container.container!.id)),
          )
          .response;
      response.data!.items!.forEach((element) {
        messages.add(element!);
        messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      });
      g.Get.log('response: ${response.data!.items}');
      g.Get.log('From Server');
      isloading.value = false;
      response.data!.items!.forEach((element) {
        if (element!.userID == userid) {
          return;
        }
        if (element.messageStatus == MessageStatus.SENT) {
          final request = ModelMutations.update(element.copyWith(
            messageStatus: MessageStatus.SEEN,
          ));

          Amplify.API.mutate(request: request);
        }
      });
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

  void Createsubscribe() {
    try {
      final subscriptionRequest =
          ModelSubscriptions.onCreate(Message.classType);
      final Stream<GraphQLResponse<Message>> operation = Amplify.API.subscribe(
        subscriptionRequest,
        onEstablished: () => print('Subscription established'),
      );
      Createsubscription = operation.listen(
        (event) {
          event.errors!.forEach((element) {
            Fluttertoast.showToast(msg: element.message);
          });
          if (event.data == null) return;
          if (event.data!.chatcontainerID == widget.container.container!.id) {
            if (event.data!.userID == userid)
              messages.remove(messages.firstWhere(
                (element) => element.message == event.data!.message,
              ));

            messages.add(event.data!);

            messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

            messages.refresh();
            if (event.data!.userID != userid) {
              final request = ModelMutations.update(event.data!.copyWith(
                messageStatus: MessageStatus.SEEN,
              ));

              Amplify.API.mutate(request: request);
            }
          }
          print('Subscription event data received: ${event.data}');
        },
        onError: (Object e) {
          print('Error in subscription stream: $e');
          Fluttertoast.showToast(
              msg:
                  'Failed to Load, make sure you are connected to the internet');
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Failed to Load, make sure you are connected to the internet');
    }
  }

  StreamSubscription<GraphQLResponse<Message>>? Deletesubscription;

  void Deletesubscribe() {
    try {
      final subscriptionRequest =
          ModelSubscriptions.onDelete(Message.classType);
      final Stream<GraphQLResponse<Message>> operation = Amplify.API.subscribe(
        subscriptionRequest,
        onEstablished: () => print('Delete Subscription established'),
      );
      Deletesubscription = operation.listen(
        (event) {
          event.errors!.forEach((element) {
            Fluttertoast.showToast(msg: element.message);
          });
          if (event.data!.chatcontainerID == widget.container.container!.id) {
            messages.remove(event.data!);
            messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
            messages.refresh();
          }
          print('Subscription event data received: ${event.data}');
        },
        onError: (Object e) {
          print('Error in subscription stream: $e');
          Fluttertoast.showToast(
              msg:
                  'Failed to Load, make sure you are connected to the internet');
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Failed to Load, make sure you are connected to the internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.container.icon ?? ' '),
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.container.name ?? ' ',
                style: GoogleFonts.dmSans(fontSize: 15),
                overflow: TextOverflow.ellipsis),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(UniconsLine.ellipsis_h),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(children: [
        g.Obx(() => Expanded(
            child: Container(
                child: isloading.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.pink),
                      )
                    : messages.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                UniconsLine.chat,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No Messages',
                                style: GoogleFonts.dmSans(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          )
                        : Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onLongPress: () {
                                    if (messages[index].userID == guserData!.id)
                                      g.Get.bottomSheet(
                                        Container(
                                          height: 100,
                                          child: Center(
                                            child: ListTile(
                                              leading: Icon(UniconsLine.trash),
                                              title: Text('Delete Message'),
                                              onTap: () async {
                                                final request =
                                                    ModelMutations.delete(
                                                        messages[index]);
                                                final response = await Amplify
                                                    .API
                                                    .mutate(request: request)
                                                    .response;
                                                if (response
                                                    .errors!.isNotEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: response.errors
                                                          .toString());
                                                  g.Get.back();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: 'Message Deleted');
                                                  g.Get.back();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.black,
                                        barrierColor:
                                            Color.fromARGB(92, 0, 0, 0),
                                        isDismissible: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                      );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Align(
                                          alignment: (messages[index].userID ==
                                                  guserData!.id
                                              ? Alignment.topRight
                                              : Alignment.topLeft),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: (messages[index]
                                                              .userID ==
                                                          guserData!.id
                                                      ? messages[index]
                                                                      .messageStatus ==
                                                                  MessageStatus
                                                                      .SENT ||
                                                              messages[index]
                                                                      .messageStatus ==
                                                                  MessageStatus
                                                                      .SEEN
                                                          ? Colors.pink
                                                          : Color.fromARGB(
                                                              255, 98, 95, 96)
                                                      : Colors.grey.shade200),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15),
                                                child: RichTextView(
                                                    text: messages[index]
                                                            .message ??
                                                        ' ',
                                                    textAlign: TextAlign.start,
                                                    truncate: false,
                                                    style: GoogleFonts.dmSans(
                                                        color: (messages[index]
                                                                    .userID ==
                                                                guserData!.id
                                                            ? Colors.white
                                                            : Colors.black),
                                                        fontSize: 15),
                                                    linkStyle: GoogleFonts.dmSans(
                                                        color: messages[index]
                                                                    .userID ==
                                                                guserData!.id
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize: 15,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    supportedTypes: [
                                                      EmailParser(
                                                          onTap: (email) =>
                                                              launchUrlString(
                                                                  'mailto:${email.value}')),
                                                      PhoneParser(
                                                          onTap: (phone) =>
                                                              launchUrlString(
                                                                  'tel:${phone.value}')),
                                                      UrlParser(
                                                          onTap: (url) =>
                                                              launchUrlString(
                                                                  '${url.value}'))
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14, bottom: 5),
                                        child: Align(
                                          alignment: (messages[index].userID ==
                                                  guserData!.id
                                              ? Alignment.topRight
                                              : Alignment.topLeft),
                                          child: Row(
                                            mainAxisAlignment:
                                                messages[index].userID == userid
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                            children: [
                                              messages[index].createdAt != null
                                                  ? Text(
                                                      messages[index]
                                                              .createdAt!
                                                              .getDateTimeInUtc()
                                                              .hour
                                                              .toString() +
                                                          ' : ' +
                                                          messages[index]
                                                              .createdAt!
                                                              .getDateTimeInUtc()
                                                              .minute
                                                              .toString(),
                                                      style: GoogleFonts.dmSans(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              messages[index].userID ==
                                                      guserData!.id
                                                  ? messages[index]
                                                              .messageStatus ==
                                                          MessageStatus.SENT
                                                      ? Icon(
                                                          Icons.done,
                                                          color: Colors.pink,
                                                          size: 12,
                                                        )
                                                      : messages[index]
                                                                  .messageStatus ==
                                                              MessageStatus
                                                                  .SENDING
                                                          ? Icon(
                                                              UniconsLine.clock,
                                                              color:
                                                                  Colors.grey,
                                                              size: 12,
                                                            )
                                                          : Icon(
                                                              Icons.done_all,
                                                              color:
                                                                  Colors.pink,
                                                              size: 12,
                                                            )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )))),
        g.Obx(() => ListTile(
              title: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
              trailing: sending.value
                  ? const CircularProgressIndicator(color: Colors.pink)
                  : IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendMessage(messageController.text);
                      },
                      color: Colors.pink,
                    ),
            )),
      ]),
    );
  }

  g.RxBool sending = false.obs;

  sendMessage(String messagee) async {
    Message message = Message(
        userID: guserData!.id,
        chatcontainerID: widget.container.container!.id,
        message: messagee,
        messageStatus: MessageStatus.SENT);

    Message localmessage = Message(
        userID: guserData!.id,
        chatcontainerID: widget.container.container!.id,
        message: messagee,
        messageStatus: MessageStatus.SENDING);
    messages.add(localmessage);
    messageController.clear();

    final request = ModelMutations.create(message);
    final response = await Amplify.API.mutate(request: request).response;

    final createdMessage = response.data;

    print('Created message: $createdMessage');
  }
}
