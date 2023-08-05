import 'dart:io';
import 'package:dekho/Controlers/Chat/ChatModel.dart';
import 'package:dekho/Controlers/Posts/Post.dart';
import 'package:dekho/Controlers/Reels/VideoModel.dart';
import 'package:dekho/pages/Account/EditProfile.dart';
import 'package:dekho/pages/Account/FeedViewPlayer.dart';
import 'package:dekho/pages/Account/SettingsUnderPages/Wallet.dart';
import 'package:dekho/pages/Activity/UploadStory.dart';
import 'package:dekho/pages/Chat/MessageScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/main.dart';
import 'package:dekho/models/Follow.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:dekho/pages/Account/Settings.dart';
import 'package:dekho/pages/UploadVideo/UploadPage.dart';
import 'package:dekho/widgets/notSignedin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';

import '../../Controlers/AppData/AppdataController.dart';
import '../../Controlers/Chat/ChatController.dart';
import '../../Controlers/Reels/ReelsVideoController.dart';
import '../../models/User.dart';
import '../../widgets/ActivityWidgets/widgets/post_container.dart';
import '../Activity/PostUploadPage.dart';
import '../UploadVideo/CameraPage.dart';

class AccountPage extends StatefulWidget {
  String? userid;
  User? userData;
  bool doit;
  AccountPage({super.key, this.userid, this.userData, required this.doit});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final feedViewModel = GetIt.instance<FeedViewModel>();
  final appdata = GetIt.instance<AppData>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
  }

  late User userData;
  int followers = 0;
  int following = 0;
  List posts = [];
  List<PostLocal> posts2 = [];
  bool isLoading = true;
  Follow? follwedData;
  String followstring = 'Follow';
  bool showprivate = false;

  getdata() async {
    if (widget.userid == null && !isSignedin) {
      return;
    }
    Get.log(widget.userid.toString());
    final id = widget.userid ?? userid;

    if (widget.userid == null || widget.userid == userid) {
      if (mounted)
        setState(() {
          userData = guserData!;
          isme = true;
        });
    } else {
      print(id);
      if (widget.userData != null) {
        userData = widget.userData!;
      } else {
        final request = ModelQueries.get(User.classType, id);
        final response = await Amplify.API.query(request: request).response;
        print(response.data);
        userData = response.data!;
      }

      if (mounted)
        setState(() {
          isme = false;
          isLoading = false;
        });
    }
    if (id == userid) {
      posts = appdata.userposts;
      posts.where((element) => element!.isReel == false).forEach((element) {
        PostLocal post = PostLocal.fromJson(element!.toJson(), element, null);
        posts2.add(post);
      });
    } else {
      if (userData.accountType == 'Public') {
        final potsqry = ModelQueries.list(PostModel.classType,
            where: PostModel.USERID.eq(id));
        final potsres = await Amplify.API.query(request: potsqry).response;
        posts = potsres.data!.items;
        posts.where((element) => element!.isReel == false).forEach((element) {
          PostLocal post = PostLocal.fromJson(element!.toJson(), element, null);
          posts2.add(post);
        });
      } else {
        final box = GetStorage();
        List ids = box.read('followingUsers') ?? [];
        if (ids.contains(id)) {
          final potsqry = ModelQueries.list(PostModel.classType,
              where: PostModel.USERID.eq(id));
          final potsres = await Amplify.API.query(request: potsqry).response;
          posts = potsres.data!.items;
          posts.where((element) => element!.isReel == false).forEach((element) {
            PostLocal post =
                PostLocal.fromJson(element!.toJson(), element, null);
            posts2.add(post);
          });
        } else {
          if (mounted)
            setState(() {
              showprivate = true;
            });
        }
      }
    }
    if (mounted)
      setState(() {
        isLoading = false;
      });

    final jqury = ModelQueries.list(Follow.classType,
        where: Follow.FOLLOWING.eq(id).or(Follow.FOLLOWEDBY.eq(guserData!.id)));
    final jres = await Amplify.API.query(request: jqury).response;

    final j = userData.accountType == 'Private'
        ? jres.data!.items.where((element) => element!.accepted == true)
        : jres.data!.items;

    try {
      print("${jres.data!.items.length} data");

      if (jres.data != null) {
        print(jres);
        final j = jres.data!.items.first;
        if (j!.accepted != true) {
          followstring = "Requested";
        } else if (j.following == id &&
            j.followedby == guserData!.id &&
            j.accepted == true) {
          followstring = "Unfollow";
        }
        followed.value = true;
        follwedData = j;
      }
    } catch (e) {}

    followers = j.where((element) => element!.following == id).length;
    following = j.where((element) => element!.followedby == id).length;
    if (mounted) setState(() {});
  }

  bool isme = true;

  bool snap = false;

  @override
  Widget build(BuildContext context) {
    return !isSignedin
        ? NotSignedIn()
        : isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              )
            : snap
                ? Center(
                    child: Text(
                      'Something Went Wrong, try again',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Scaffold(
                    backgroundColor: Colors.black,
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            // border: Border(
                            //   bottom: BorderSide(
                            //     color: Color.fromARGB(255, 220, 220, 220),
                            //   ),
                            // ),
                            ),
                        child: AppBar(
                          backgroundColor: Colors.black,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '@' +
                                    (userData.username ?? guserData!.username!),
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: userData.username));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Username Copied')));
                                  },
                                  child: Icon(Icons.copy,
                                      color: Colors.white, size: 15)),
                            ],
                          ),
                          centerTitle: false,
                          elevation: 0,
                          actions: [
                            if (isme)
                              IconButton(
                                onPressed: () {
                                  if (uploadingVideo.value == true) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Please Wait, another video is uploading',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  }
                                  Get.bottomSheet(
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(() => Cam());
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    UniconsLine.video,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text('Upload Reel'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(() => PostUploadPage());
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    UniconsLine.comment,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text('Create Post'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(() => StoryCam());
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    UniconsLine.slider_h,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text('Add Story'),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    backgroundColor: Colors.black,
                                  );
                                },
                                icon: Icon(
                                  // Icons.favorite,
                                  UniconsLine.plus_circle,
                                  color: Colors.pink,
                                ),
                              ),
                            if (isme)
                              IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(_createRoute(SettingsPage()));
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                    body: DefaultTabController(
                      length: 2,
                      child: NestedScrollView(
                        physics: BouncingScrollPhysics(),
                        headerSliverBuilder: (context, _) {
                          return [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  profileHeaderWidget(
                                    context,
                                    userData,
                                    followers,
                                    following,
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                        body: Column(
                          children: <Widget>[
                            Material(
                              color: Colors.black,
                              child: TabBar(
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey[400],
                                indicatorWeight: 1,
                                indicatorColor: Colors.white,
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      IconlyLight.video,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Tab(
                                      icon: Icon(
                                    Icons.grid_view_rounded,
                                    color: Colors.white,
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  // Gallery(),
                                  // Igtv(),
                                  // Reels(),
                                  myReels(),
                                  myPosts()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
  }

  Widget myReels() {
    final myposts = posts.where((element) => element!.isReel == true).toList();
    return showprivate
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  UniconsLine.lock,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  'This Account is Private',
                  style: GoogleFonts.dmSans(color: Colors.white),
                ),
              ],
            ),
          )
        : myposts.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconlyLight.video, color: Colors.white, size: 50),
                    Text(
                      'No Reels Yet',
                      style: GoogleFonts.dmSans(color: Colors.white),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                itemCount: myposts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.to(() => FeedViewPlayer(
                          video: Video.fromJson(myposts[index].toJson(),
                              myposts[index], userData)!,
                        )),
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.network(
                              posts[index]!.previewimage ??
                                  'https://imgs.search.brave.com/qPqWG-tRgbOQWtyCFkDlL495n_pYS1NZ_QxbIi1rrKw/rs:fit:711:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5L/bi03MlFEaS11Ym5S/aG1lUGdMZ1VRSGFF/OCZwaWQ9QXBp',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Icon(
                                        //   Icons.remove_red_eye_sharp,
                                        //   color: Colors.white,
                                        //   size: 15,
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // Text(
                                        //   posts[index].viewCount == null
                                        //       ? '0'
                                        //       : posts[index]
                                        //           .viewCount!
                                        //           .length
                                        //           .toString(),
                                        //   style: TextStyle(
                                        //       color: Colors.white, fontSize: 12),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          posts[index]!.arrayLikes == null
                                              ? '0'
                                              : posts[index]!
                                                  .arrayLikes!
                                                  .length
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 5),
              );
  }

  Widget myPosts() {
    return showprivate
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  UniconsLine.lock,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  'This Account is Private',
                  style: GoogleFonts.dmSans(color: Colors.white),
                ),
              ],
            ),
          )
        : posts2.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(UniconsLine.comment, color: Colors.white, size: 50),
                    SizedBox(height: 5),
                    Text(
                      'No Posts',
                      style: GoogleFonts.dmSans(color: Colors.white),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: ((context, index) {
                  return PostContainer(
                    post: posts2[index].post!,
                    postlocal: posts2[index],
                  );
                }),
                itemCount: posts2.length);
  }

  void followUser(id) async {
    if (followed.value == true) {
      print(follwedData!.id);
      final request = ModelMutations.delete(Follow(id: follwedData!.id));
      final response = await Amplify.API.mutate(request: request).response;

      Get.log('df - ' + response.data.toString());
      Get.back();
      followed.value = false;
    } else {
      final todo = Follow(
          followedby: guserData!.id,
          following: id,
          username: guserData!.username,
          pfp: guserData!.pfp,
          accepted: userData.accountType == 'Private' ? false : true,
          time: TemporalDateTime.now());
      final request = ModelMutations.create(todo);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTodo = response.data;
      if (createdTodo != null) {
        follwedData = createdTodo;
        if (userData.accountType == 'Private') {
          followstring = "Requested";
        }
        print('followed');
        Get.back();
        followed.value = true;
      }
    }
  }

  Widget profileHeaderWidget(
    BuildContext context,
    User userData,
    followers,
    following,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isme)
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xff74EDED),
                    backgroundImage:
                        NetworkImage(userData.pfp ?? guserData!.pfp!),
                  ),
                if (isme)
                  CachedNetworkImage(
                    imageUrl: guserData!.pfp!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   children: [
                    //     Text(
                    //       posts.toString() ?? "0",
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Posts",
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         color: Colors.white,
                    //         letterSpacing: 0.4,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          followers.toString() ?? "0",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          following.toString() ?? "0",
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(
                            letterSpacing: 0.4,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  userData.name!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                userData.verified == null || userData.verified == false
                    ? SizedBox()
                    : InkWell(
                        onTap: (() =>
                            Fluttertoast.showToast(msg: 'Verified Dekho User')),
                        child: Icon(
                          Icons.verified_sharp,
                          size: 20,
                          color: Colors.pink,
                        ))
              ],
            ),

            Text(
              userData.bio ?? 'No bio',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            actions(context),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 85,
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemCount: highlightItems.length,
            //     itemBuilder: (context, index) {
            //       return Row(
            //         children: [
            //           Column(
            //             children: [
            //               CircleAvatar(
            //                 radius: 30,
            //                 backgroundColor: Colors.grey,
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(2.0),
            //                   child: CircleAvatar(
            //                     backgroundImage:
            //                         AssetImage(highlightItems[index].thumbnail),
            //                     radius: 28,
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 4),
            //                 child: Text(
            //                   highlightItems[index].title,
            //                   style: TextStyle(fontSize: 13),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             width: 10,
            //           )
            //         ],
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  final followed = false.obs;

  Widget actions(BuildContext context) {
    final clicked = false.obs;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Obx(() => (ElevatedButton(
                child: followed.isTrue
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                            isme
                                ? "Edit Profile"
                                : followed.isTrue
                                    ? followstring
                                    : "Follow",
                            style: TextStyle(color: Colors.white)),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                            isme
                                ? "Edit Profile"
                                : followed.isTrue
                                    ? followstring
                                    : "Follow",
                            style: TextStyle(color: Colors.white)),
                      ),
                style: OutlinedButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Colors.pink,
                  minimumSize: Size(0, 30),
                ),
                onPressed: () {
                  clicked.value = true;
                  if (isme) {
                    Get.to(() => EditProfile());
                  } else {
                    Get.dialog(
                        Center(
                          child: CircularProgressIndicator(color: Colors.pink),
                        ),
                        barrierDismissible: false);
                    followUser(userData.id);
                  }
                },
              ))),
        ),
        if (!isme)
          SizedBox(
            width: 10,
          ),
        if (!isme)
          OutlinedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AutoSizeText("Message",
                  style: TextStyle(color: Colors.white)),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white, width: 0.2),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 30),
            ),
            onPressed: () async {
              Get.dialog(
                  Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  ),
                  barrierDismissible: false);
              final chatController = GetIt.instance<ChatController>();
              List chatlist = chatController.chatlist;
              if (chatlist.isNotEmpty) {
                ChatModel? ll = chatlist.firstWhereOrNull((element) =>
                    element.members!.contains(userData.id) &&
                    element.members!.contains(guserData!.id));
                if (ll != null) {
                  Get.back();
                  Get.to(() => MessageScreen(
                        container: ll,
                      ));
                } else {
                  final model = ChatContainer(
                    isGroup: false,
                    startedby: guserData!.id,
                    members: [userData.id, guserData!.id],
                    startTime: TemporalDateTime.now(),
                    icon: "",
                    Messages: [],
                    title: "",
                    description: "",
                  );
                  final request = ModelMutations.create(model);
                  final response =
                      await Amplify.API.mutate(request: request).response;

                  final createdChatContainer = response.data;
                  ChatModel jk = ChatModel.fromJson(
                    createdChatContainer!.toJson(),
                    userData,
                    createdChatContainer,
                  );

                  chatController.chatlist.add(jk);

                  Get.back();
                  Get.to(() => MessageScreen(
                        container: jk,
                      ));
                }
              } else {
                final model = ChatContainer(
                  isGroup: false,
                  startedby: guserData!.id,
                  members: [userData.id, guserData!.id],
                  Messages: [],
                  startTime: TemporalDateTime.now(),
                  icon: "",
                  title: "",
                  description: "",
                );
                final request = ModelMutations.create(model);
                final response =
                    await Amplify.API.mutate(request: request).response;

                final createdChatContainer = response.data;
                Get.log(response.errors.toString());
                ChatModel jk = ChatModel.fromJson(
                  createdChatContainer!.toJson(),
                  userData,
                  createdChatContainer,
                );
                chatController.chatlist.add(jk);

                Get.back();
                Get.to(() => MessageScreen(
                      container: jk,
                    ));
              }
            },
          ),
        if (isme)
          SizedBox(
            width: 10,
          ),
        if (isme)
          OutlinedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(Icons.wallet, color: Colors.white, size: 15),
                  SizedBox(
                    width: 5,
                  ),
                  AutoSizeText("Wallet", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white, width: 0.2),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size(0, 30),
            ),
            onPressed: () {
              Get.to(() => WalletPage());
            },
          )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (widget.doit == true) {
      try {
        feedViewModel.videos[feedViewModel.prevVideo].controller!.play();
      } catch (e) {}
    }
  }
}

Route _createRoute(page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
