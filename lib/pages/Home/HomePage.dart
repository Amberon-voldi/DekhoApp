import 'dart:async';

import 'package:rich_text_view/rich_text_view.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:chewie/chewie.dart';
import 'package:dekho/Controlers/Reels/ReelsVideoController.dart';
import 'package:dekho/Utils/CommentSheetModel.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/Follow.dart';
import 'package:dekho/models/LikeModel.dart';
import 'package:dekho/pages/Account/AccountPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';
import 'package:video_player/video_player.dart';

import '../../Auth/AuthHero.dart';
import '../../Controlers/Reels/VideoModel.dart';
import '../../main.dart';
import '../../models/PostModel.dart';
import '../UploadVideo/CameraPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final feedViewModel = GetIt.instance<FeedViewModel>();
  late PageController controller;
  @override
  void initState() {
    // TODO: implement initState

    controller = PageController(
      keepPage: true,
      initialPage: feedViewModel.prevVideo,
      viewportFraction: 1,
    );
    startsetstate();

    super.initState();
    // feedViewModel.playv();
  }

  bool stopsetstate = false;

  Timer? timer;
  bool isgesture = false;
  startsetstate() {
    final timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!stopsetstate) {
        if (mounted) setState(() {});
      }
      try {
        if (feedViewModel.prevVideo == 0 && isgesture == false) {
          if (feedViewModel.videos[0].controller!.value.isPlaying == false) {
            if (mounted) feedViewModel.videos[0].controller!.play();
          }
        }
      } catch (e) {}
    });
    print('done');
    timer;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    try {
      timer!.cancel();
      timer = null;
    } catch (e) {
      print(e.toString() + 'timer');
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<FeedViewModel>.reactive(
        staticChild: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(),
              Text('Loading')
            ],
          ),
        ),
        onModelReady: (model) {
          try {
            if (feedViewModel.videos[feedViewModel.prevVideo + 1].controller ==
                null) {
              feedViewModel.videos[feedViewModel.prevVideo + 1]
                  .loadController();
              print('loaded vid controllers');
            }
            if (feedViewModel.videos[feedViewModel.prevVideo - 1].controller ==
                    null &&
                feedViewModel.prevVideo != 0) {
              feedViewModel.videos[feedViewModel.prevVideo - 1]
                  .loadController();
            }
          } catch (e) {
            print(e);
          }
          isgesture = false;
          try {
            model.playv();
          } catch (e) {
            print(e);
          }
        },
        disposeViewModel: false,
        onDispose: (model) {
          try {
            model.pause();
          } catch (e) {
            print(e);
          }
          isgesture = true;
          try {
            if (feedViewModel.videos[feedViewModel.prevVideo + 1].controller !=
                null) {
              feedViewModel.videos[feedViewModel.prevVideo + 1].controller!
                  .dispose();
              feedViewModel.videos[feedViewModel.prevVideo + 1].controller =
                  null;
              print('disposed vid controllers');
            }
            if (feedViewModel.videos[feedViewModel.prevVideo - 1].controller !=
                    null &&
                feedViewModel.prevVideo != 0) {
              feedViewModel.videos[feedViewModel.prevVideo - 1].controller!
                  .dispose();
              feedViewModel.videos[feedViewModel.prevVideo - 1].controller =
                  null;
            }
          } catch (e) {
            print(e);
          }
        },
        builder: (context, model, child) => Reel(),
        viewModelBuilder: () => feedViewModel,
      ),
    );
  }

  Widget Reel() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: PageView.builder(
              itemCount: feedViewModel.videos.length,
              controller: controller,
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                index = index % (feedViewModel.videos.length);
                if (stopsetstate) {
                  stopsetstate = false;
                }
                if (isfollowingtheuser) {
                  isfollowingtheuser = false;
                }
                if (controller.position.userScrollDirection ==
                    ScrollDirection.forward) {
                  feedViewModel.changeVideo(
                    index,
                    false,
                  );
                } else if (controller.position.userScrollDirection ==
                    ScrollDirection.reverse) {
                  feedViewModel.changeVideo(
                    index,
                    true,
                  );
                }

                if (index == feedViewModel.videos.length - 9) {
                  feedViewModel.getmorevideos();
                }
              },
              itemBuilder: (context, index) {
                return feedViewModel.videos == []
                    ? Center(
                        child: Column(children: [
                          CircularProgressIndicator(),
                          SizedBox(),
                          Text('Loading')
                        ]),
                      )
                    : myreelVideo(feedViewModel.videos[index]);
              }),
        ),
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     height: 50,
        //     width: double.infinity,
        //     color: Colors.black.withOpacity(0.2),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         Container(
        //           child: Row(
        //             children: [
        //               Text('Following', style: GoogleFonts.dmSans()),
        //               SizedBox(
        //                 width: 10,
        //               ),
        //               Text('|'),
        //               SizedBox(
        //                 width: 10,
        //               ),
        //               Text('Trending', style: GoogleFonts.dmSans()),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Route _createRoute(page) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  bool isfollowingtheuser = false;

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
              child: video.controller == null ||
                      video.controller!.value.isInitialized == false
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
                          if (!stopsetstate) {
                            stopsetstate = true;
                          }
                          if (isliked.value == false) {
                            likes.value++;
                            isliked.value = true;
                            likesheartop.value = true;
                            feedViewModel.likevideo(
                                video.id!, video.postData!, video);
                          } else {
                            likes.value--;
                            isliked.value = false;
                            feedViewModel.likevideo(
                                video.id!, video.postData!, video);
                          }
                        },
                        onLongPressStart: (details) {
                          isgesture = true;
                          if (!stopsetstate) {
                            stopsetstate = true;
                          }
                          video.controller!.pause();
                          opacitytriggered.value = true;
                        },
                        onLongPressEnd: (details) {
                          isgesture = false;
                          if (!stopsetstate) {
                            stopsetstate = true;
                          }
                          video.controller!.play();
                          opacitytriggered.value = false;
                        },
                        child: video.controller!.value.aspectRatio == 16 / 9
                            ? AspectRatio(
                                aspectRatio:
                                    video.controller!.value.aspectRatio ?? 1,
                                child: VideoPlayer(video.controller!))
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(
                                    child: VideoPlayer(video.controller!)),
                              ),
                      ),
                    ),
            ),
            AnimatedOpacity(
              opacity: opacitytriggered.value ? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
                            RichTextView(
                                text: video.videoTitle!,
                                maxLines: 1,
                                truncate: true,
                                viewLessText: 'less',
                                linkStyle: TextStyle(color: Colors.pink),
                                supportedTypes: [
                                  EmailParser(
                                      onTap: (email) =>
                                          print('${email.value} clicked')),
                                  PhoneParser(
                                      onTap: (phone) =>
                                          print('click phone ${phone.value}')),
                                  MentionParser(
                                      onTap: (mention) =>
                                          print('${mention.value} clicked')),
                                  UrlParser(
                                      onTap: (url) =>
                                          print('visting ${url.value}?')),
                                  BoldParser(),
                                  HashTagParser(
                                      onTap: (hashtag) => print(
                                          'is ${hashtag.value} trending?'))
                                ]),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                      onTap: () {
                                        if (video.userID != null) {
                                          try {
                                            feedViewModel
                                                .videos[feedViewModel.prevVideo]
                                                .controller!
                                                .pause();
                                          } catch (e) {}
                                          isgesture = true;
                                          Navigator.of(context)
                                              .push(_createRoute(AccountPage(
                                            userid: video.userID!,
                                            userData: video.userdetails,
                                            doit: true,
                                          )));
                                        }
                                      },
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
                                    StatefulBuilder(
                                      builder:
                                          (BuildContext context, setState) {
                                        final data = GetStorage()
                                                .read('followingUsers') ??
                                            [];
                                        final isFollowing =
                                            data.contains(video.userdetails);
                                        return isFollowing
                                            ? Container()
                                            : Positioned(
                                                right: 0,
                                                left: 0,
                                                bottom: 0,
                                                child: Center(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (isSignedin == false) {
                                                        SnackBar snackBar =
                                                            SnackBar(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  39,
                                                                  39,
                                                                  39),
                                                          content: Text(
                                                            'Please sign in to continue',
                                                            style: GoogleFonts
                                                                .dmSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      } else {
                                                        setState(() {
                                                          isfollowingtheuser =
                                                              true;
                                                        });
                                                        final box =
                                                            GetStorage();
                                                        List following = box.read(
                                                                'followingUsers') ??
                                                            [];
                                                        Get.log(following
                                                            .toString());
                                                        following.add(
                                                            video.userdetails!);
                                                        box.write(
                                                            'followingUsers',
                                                            following);
                                                        Get.log('jhj');
                                                        final todo = Follow(
                                                          following: video
                                                              .userdetails!.id,
                                                          followedby:
                                                              guserData!.id,
                                                          username: guserData!
                                                              .username,
                                                          pfp: guserData!.pfp,
                                                          accepted: video
                                                                      .userdetails!
                                                                      .accountType ==
                                                                  'public'
                                                              ? true
                                                              : false,
                                                        );
                                                        final request =
                                                            ModelMutations
                                                                .create(todo);
                                                        final response =
                                                            await Amplify.API
                                                                .mutate(
                                                                    request:
                                                                        request)
                                                                .response;
                                                        Get.log(response.data
                                                            .toString());
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'You are now following ${video.userdetails!.username}',
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.pink,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2)),
                                                      child: Icon(
                                                        // Icons.favorite,
                                                        UniconsLine.plus,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                      },
                                    ),
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
                                    if (!stopsetstate) {
                                      stopsetstate = true;
                                    }
                                    if (isliked.value == false) {
                                      isliked.value = true;
                                      likes.value++;
                                      feedViewModel.likevideo(
                                          video.id!, video.postData!, video);
                                    } else {
                                      isliked.value = false;

                                      likes.value--;
                                      feedViewModel.likevideo(
                                          video.id!, video.postData!, video);
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
                                    if (!stopsetstate) {
                                      stopsetstate = true;
                                    }
                                    commentSheetModel(
                                        video.id!,
                                        video.comments,
                                        video.isCommentDisabled,
                                        video.postData);
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
