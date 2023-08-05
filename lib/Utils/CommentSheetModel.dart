import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Utils/variables.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../models/ModelProvider.dart';
import '../models/PostModel.dart';

commentSheetModel(videoid, comments, iscommentoff, PostModel post) {
  Get.bottomSheet(
    CommentList(
      datalist: comments,
      isCommentDisabled: iscommentoff,
      postData: post,
    ),
    elevation: 2,
    backgroundColor: Colors.black,
    barrierColor: Color.fromARGB(92, 0, 0, 0),
    isDismissible: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  );
}

class CommentList extends StatefulWidget {
  List<CommentModel?>? datalist;
  PostModel postData;
  bool isCommentDisabled;

  CommentList(
      {super.key,
      required this.datalist,
      required this.isCommentDisabled,
      required this.postData});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  bool isloading = true;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: widget.isCommentDisabled
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          UniconsLine.comment_alt_exclamation,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Comment is off',
                          style: GoogleFonts.dmSans(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'You cannot comment beacouse the user has disabled comment on this post.',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )
                : widget.datalist!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              UniconsLine.comment,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('No Comment'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: widget.datalist!.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(widget
                                      .datalist![index]!.pfp ??
                                  'https://cdn.discordapp.com/attachments/926965175125413898/1058867723779715123/th.png'),
                            ),
                            subtitle: Text(
                              widget.datalist![index]!.comment!,
                              style: GoogleFonts.dmSans(color: Colors.white),
                            ),
                            title: Text(
                              "@" + widget.datalist![index]!.username!,
                              style: GoogleFonts.dmSans(
                                color: Color.fromARGB(255, 105, 105, 105),
                              ),
                            ),
                          );
                        }),
                      )),
        if (!widget.isCommentDisabled)
          ListTile(
            trailing: Icon(
              UniconsLine.message,
              color: Colors.white,
            ),
            // leading: CircleAvatar(
            //   radius: 20,
            //   backgroundImage: NetworkImage(
            //       'https://cdn.discordapp.com/attachments/926965175125413898/1058867723779715123/th.png'),
            // ),
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
            onTap: () async {
              if (commentController.text.isNotEmpty) {
                final commentitem = CommentModel(
                  userID: userid,
                  comment: commentController.text,
                  username: guserData!.username,
                  time: TemporalDateTime.now(),
                  isReply: false,
                  pfp: guserData!.pfp,
                );
                final item = widget.postData.copyWith(
                  comments: widget.postData.comments == null
                      ? [commentitem]
                      : [...widget.postData.comments!, commentitem],
                );
                final request = ModelMutations.update(item);
                final response =
                    await Amplify.API.mutate(request: request).response;

                final createdTodo = response.data;
                print(response.data);

                widget.postData.comments.add(commentitem);

                commentController.clear();
                if (mounted) setState(() {});
              } else {
                Get.snackbar('Error', 'Comment cannot be empty');
              }
            },
          )
      ],
    );
  }
}
