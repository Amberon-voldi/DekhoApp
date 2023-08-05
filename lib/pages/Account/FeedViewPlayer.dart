import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Controlers/Reels/ReelsVideoController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';
import 'package:video_player/video_player.dart';

import '../../Controlers/Reels/VideoModel.dart';
import '../../Utils/CommentSheetModel.dart';
import '../../Utils/variables.dart';
import '../../main.dart';
import '../../models/ModelProvider.dart';

class FeedViewPlayer extends StatefulWidget {
  Video video;
  FeedViewPlayer({super.key, required this.video});

  @override
  State<FeedViewPlayer> createState() => _FeedViewPlayerState();
}

class _FeedViewPlayerState extends State<FeedViewPlayer> {
  late VideoPlayerController controller;
  final isplay = false.obs;

  @override
  void initState() {
    // TODO: implement initState

    readyplayer();

    super.initState();
    // feedViewModel.playv();
  }

  readyplayer() async {
    controller = VideoPlayerController.network(widget.video.url)..initialize();
    controller.setLooping(true);
    await controller.play();
    controller.addListener(() {
      if (controller.value.isPlaying) {
        isplay.value = true;
      }
    });
  }

  bool isgesture = false;

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: myreelVideo(widget.video));
  }

  Widget myreelVideo(Video video) {
    final likesheartop = false.obs;
    final opacitytriggered = false.obs;

    final jn = video.likesArray ?? [];

    RxInt likes =
        jn.isEmpty ? 0.obs : int.parse(video.likesArray!.length.toString()).obs;
    bool checkisliked(video) {
      if (jn.isEmpty || !jn.contains(userid)) {
        return false;
      } else {
        return true;
      }
    }

    final isliked = checkisliked(video).obs;

    return Obx(() => Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black,
              child: isplay.value == false
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.network(
                              video.previewimage!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Center(
                            child: CircularProgressIndicator(
                                color: Color.fromRGBO(33, 150, 243, 1)),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (isliked.value == false) {
                            likes.value++;
                            isliked.value = true;
                            likesheartop.value = true;
                            // feedViewModel.likevideo(
                            //     video.id!, video.postData!, video);
                          } else {
                            likes.value--;
                            isliked.value = false;
                            // feedViewModel.likevideo(
                            //     video.id!, video.postData!, video);
                          }
                        },
                        onLongPressStart: (details) {
                          controller.pause();
                          opacitytriggered.value = true;
                        },
                        onLongPressEnd: (details) {
                          controller.play();
                          opacitytriggered.value = false;
                        },
                        child: controller!.value.aspectRatio == 16 / 9
                            ? AspectRatio(
                                aspectRatio: controller!.value.aspectRatio ?? 1,
                                child: VideoPlayer(controller!))
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(child: VideoPlayer(controller!)),
                              ),
                      ),
                    ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.7),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            AnimatedOpacity(
              opacity: opacitytriggered.value ? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: EdgeInsets.only(
                        left: 20, bottom: video.videoTitle != null ? 25 : 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '@',
                              style: GoogleFonts.dmSans(
                                  color: Colors.pink,
                                  fontSize: 15,
                                  shadows: [
                                    // Shadow(blurRadius: 4, color: Colors.black)
                                  ],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              video.userdetails == null
                                  ? video.username.toString()
                                  : video.userdetails!.username!,
                              style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            video.userdetails != null
                                ? video.userdetails!.verified == null ||
                                        video.userdetails!.verified == false
                                    ? SizedBox()
                                    : Icon(
                                        Icons.verified,
                                        size: 20,
                                        shadows: [],
                                        color: Colors.pink,
                                      )
                                : Container()
                          ],
                        ),
                        if (video.videoTitle != null)
                          SizedBox(
                            height: 10,
                          ),
                        if (video.videoTitle != null)
                          Text(
                            video.videoTitle.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                                color: Colors.white, fontSize: 14),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width / 6,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.dialog(Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          // Icons.favorite,
                                          UniconsLine.rupee_sign,
                                          color: Colors.pink,
                                          size: 40,
                                        ),
                                        Text(
                                          'Support',
                                          style: GoogleFonts.dmSans(
                                              color: Colors.pink,
                                              decoration: TextDecoration.none,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Support your favorite creators by gifting them a small token of appreciation, This will help them to create more content for you',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'This feature is currently in working progress',
                                          style: GoogleFonts.dmSans(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 12),
                                        ),
                                      ]),
                                ));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      // Icons.favorite,
                                      UniconsLine.rupee_sign,
                                      color: Colors.pink,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Support',
                                      style: GoogleFonts.dmSans(
                                          color: Colors.pink,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              child: Stack(
                                children: [
                                  Center(
                                      child: InkWell(
                                    child: CircleAvatar(
                                      foregroundImage: NetworkImage(video
                                                  .userdetails ==
                                              null
                                          ? video.pfp ??
                                              'https://i.imgur.com/ClEwudY.png'
                                          : video.userdetails!.pfp!),
                                      radius: 25,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (isSignedin == false) {
                                  SnackBar snackBar = SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 39, 38, 38),
                                    content: Text(
                                      'Please Signin to like',
                                      style: GoogleFonts.dmSans(
                                          color: Colors.white),
                                    ),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  if (isliked.value == false) {
                                    isliked.value = true;
                                    likes.value++;
                                    // feedViewModel.likevideo(
                                    //     video.id!, video.postData!, video);
                                  } else {
                                    isliked.value = false;

                                    likes.value--;
                                    // feedViewModel.likevideo(
                                    //     video.id!, video.postData!, video);
                                  }
                                }
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    isliked.value
                                        ? Icon(
                                            // Icons.favorite,
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 30,
                                          )
                                        : Icon(
                                            // Icons.favorite,
                                            UniconsLine.heart,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      likes.value.toString(),
                                      style: GoogleFonts.dmSans(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (isSignedin == false) {
                                  SnackBar snackBar = SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 39, 38, 38),
                                    content: Text(
                                      'Please Signin to comment',
                                      style: GoogleFonts.dmSans(
                                          color: Colors.white),
                                    ),
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  commentSheetModel(video.id!, video.comments,
                                      video.isCommentDisabled, video.postData);
                                }
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      // Icons.favorite,
                                      UniconsLine.comment,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      video.comments == null
                                          ? '0'
                                          : video.comments!.length.toString(),
                                      style: GoogleFonts.dmSans(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                FlutterShare.share(
                                    title: 'Share Dekho',
                                    text: 'Share Dekho',
                                    linkUrl:
                                        'https://play.google.com/store/apps/details?id=com.mythics.dekho');
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    Icon(
                                      // Icons.favorite,
                                      UniconsLine.share,
                                      color: Colors.pink,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Share',
                                      style: GoogleFonts.dmSans(
                                          color: Colors.pink, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: likesheartop.value ? 1 : 0,
              duration: Duration(milliseconds: 200),
              onEnd: () {
                Timer(Duration(milliseconds: 500), () {
                  likesheartop.value = false;
                });
              },
              child: Center(
                child: Icon(
                  Icons.favorite,
                  shadows: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 55,
                        spreadRadius: 50,
                        offset: Offset(0, 0))
                  ],
                  color: Colors.pinkAccent,
                  size: 150,
                ),
              ),
            )
          ],
        )));
  }
}
