// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dekho/Auth/AuthHero.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/main.dart';
import 'package:dekho/pages/Account/AccountPage.dart';
import 'package:dekho/pages/Activity/ActivityPage.dart';
import 'package:dekho/pages/Chat/TabPage.dart';
import 'package:dekho/pages/Home/HomePage.dart';
import 'package:dekho/pages/Search/SearchPage.dart';
import 'package:dekho/pages/UploadVideo/CameraPage.dart';
import 'package:dekho/pages/UploadVideo/UploadPage.dart';
import 'package:drishya_picker/drishya_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import 'Controlers/AppData/AppdataController.dart';
import 'Controlers/Chat/ChatController.dart';
import 'Controlers/Reels/ReelsVideoController.dart';
import 'models/User.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final appDataModel = GetIt.instance<AppData>();
  final chatData = GetIt.instance<ChatController>();
  final feedviiewmodel = GetIt.instance<FeedViewModel>();
  late CamController controller;

  // final _gallerySetting = GallerySetting(
  //   enableCamera: true,
  //   maximumCount: 10,
  //   requestType: RequestType.all,
  //   editorSetting: EditorSetting(colors: _colors, stickers: _stickers1),
  //   cameraSetting: const CameraSetting(videoDuration: Duration(seconds: 15)),
  //   cameraTextEditorSetting: EditorSetting(
  //     backgrounds: _defaultBackgrounds,
  //     colors: _colors.take(4).toList(),
  //     stickers: _stickers2,
  //   ),
  //   cameraPhotoEditorSetting: EditorSetting(
  //     colors: _colors.skip(4).toList(),
  //     stickers: _stickers3,
  //   ),
  // );

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    controller = CamController();

    super.initState();
  }

  getuserid() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userid');

    userid = id.toString();

    final key = prefs.getString('userid');
    try {
      if (key == null) {
        return;
      }
      final userAttributes = await Amplify.Auth.fetchUserAttributes();
      print(userAttributes);
      final queryPredicate = User.EMAIL.eq(userAttributes[3].value.toString());
      Get.log(userAttributes[3].value.toString());

      final request = ModelQueries.get(User.classType, key!);
      final response = await Amplify.API.query(request: request).response;

      final iserinfo = response.data!;

      userid = iserinfo.id;
      guserData = iserinfo;
      print('Asigned user info');
      appDataModel.getfollowersData();
    } catch (e) {
      print(e);
    }
  }

  final index = 0.obs;

  void changeindex(i) async {
    // if (i == 2) {
    //   if (isSignedin) {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => Cam()));
    //     return;
    //   } else {
    //     Get.to(() => AuthHero());
    //     Fluttertoast.showToast(
    //         msg: 'Please Login to Upload',
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.black,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //     return;
    //   }
    // }
    setState(() {
      index.value = i;
      if (i != 1) {
        try {
          if (feedviiewmodel
              .videos[feedviiewmodel.prevVideo].controller!.value.isPlaying) {
            feedviiewmodel.videos[feedviiewmodel.prevVideo].controller!.pause();
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  List Pages = <Widget>[
    ActivityPage(),
    HomePage(),
    SearchPage(),
    TabPage(),
    AccountPage(
      doit: false,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: index.value == 1 ? true : false,
      body: Stack(
        children: [
          Obx(() => Container(
                height: double.infinity,
                width: double.infinity,
                child: Pages.elementAt(index.value),
              )),
          Obx(() => Container(
                child: uploadingVideo.value == true
                    ? Positioned(
                        height: 27,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black,
                              child: Center(
                                  child: Text(
                                    'Uploading your video...',
                                    style:
                                        GoogleFonts.dmSans(color: Colors.white),
                                  ),
                                  heightFactor: 1.5),
                            ),
                            LinearProgressIndicator(
                              minHeight: 2,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        bottom: 0)
                    : null,
              ))
        ],
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomNavigationBar(
        backgroundColor:
            index == 1 ? Color.fromARGB(0, 255, 255, 255) : Colors.black,
        selectedColor: Colors.pink,
        unSelectedColor: Colors.white,
        iconSize: 27,
        currentIndex: index.value,
        onTap: changeindex,
        items: [
          CustomNavigationBarItem(
              icon: Icon(UniconsLine.home_alt),
              title: Text(
                'Posts',
                style: GoogleFonts.dmSans(
                  color: index.value == 0 ? Colors.pink : Colors.white,
                ),
              )),
          CustomNavigationBarItem(
              icon: const Icon(UniconsLine.map_marker_edit),
              title: Text(
                'Reels',
                style: GoogleFonts.dmSans(
                  color: index.value == 1 ? Colors.pink : Colors.white,
                ),
              )),
          CustomNavigationBarItem(
              icon: Icon(
                UniconsLine.search,
              ),
              title: Text(
                'Search',
                style: GoogleFonts.dmSans(
                  color: index.value == 2 ? Colors.pink : Colors.white,
                ),
              )),
          CustomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(
                    UniconsLine.envelope,
                  ),
                  // if (appDataModel.followrequests.isNotEmpty ||
                  //     chatData.chatlist.isNotEmpty)
                  //   Positioned(
                  //     right: 0,
                  //     child: Container(
                  //       padding: const EdgeInsets.all(1.5),
                  //       decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.circular(6),
                  //       ),
                  //       constraints: const BoxConstraints(
                  //         minWidth: 12,
                  //         minHeight: 12,
                  //       ),
                  //       child: Text(
                  //         appDataModel.followrequests.length +
                  //                     chatData.chatlist.length >
                  //                 9
                  //             ? '9+'
                  //             : (appDataModel.followrequests.length +
                  //                     chatData.chatlist.length)
                  //                 .toString(),
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 8,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              title: Text(
                'Messages',
                style: GoogleFonts.dmSans(
                  color: index.value == 3 ? Colors.pink : Colors.white,
                ),
              )),
          CustomNavigationBarItem(
              icon: isSignedin && guserData != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                          imageUrl: guserData!.pfp!, height: 30, width: 30))
                  : const Icon(
                      IconlyLight.profile,
                    ),
              title: Text(
                'Profile',
                style: GoogleFonts.dmSans(
                  color: index.value == 4 ? Colors.pink : Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
