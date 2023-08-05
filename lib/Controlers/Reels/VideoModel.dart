import 'package:dekho/models/CommentModel.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/CustomCacheManager.dart';

import '../../models/PostModel.dart';
import '../../models/User.dart';

class Video {
  late String id;
  late String? videoTitle;
  late String? songName;
  late bool? isCommentDisabled;
  late String userID;
  late String? username;
  late List<String>? likesArray;
  late List<CommentModel?> comments;
  late String? pfp;
  late PostModel postData;
  late User? userdetails;
  late String previewimage;

  late String url;

  VideoPlayerController? controller;

  Video(
      {required this.id,
      required this.previewimage,
      required this.userID,
      required this.isCommentDisabled,
      required this.userdetails,
      required this.videoTitle,
      required this.username,
      required this.likesArray,
      required this.postData,
      required this.pfp,
      required this.comments,
      required this.songName,
      required this.url});

  Video.fromJson(Map<dynamic, dynamic> json, PostModel Video, User? userData) {
    id = json['id'];
    videoTitle = json['caption'];
    username = json['username'];
    comments = Video.comments;
    pfp = json['pfp'];
    songName = json['song'];
    userID = json['userID'];
    likesArray = json['arrayLikes'];
    isCommentDisabled = json['isCommentDisabled'];
    previewimage = json['previewimage'];
    postData = Video;
    userdetails = userData;
    url = json['videourl'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['username'] = this.username;
  //   data['pfp'] = this.pfp;
  //   data['caption'] = this.videoTitle;
  //   data['userID'] = this.userID;
  //   data['likes'] = this.likes;
  //   data['comments'] = this.comments;
  //   data['caption'] = this.songName;
  //   data['isCommentDisabled'] = this.isCommentDisabled;
  //   data['videourl'] = this.url;
  //   data['previewimage'] = this.previewimage;
  //   return data;
  // }

  Future<Null> loadController() async {
    final file = await checkCacheFor(url);
    if (file != null) {
      controller = VideoPlayerController.file(file.file);
      controller?.initialize().catchError((error) async {
        print(error.toString());
        controller?.initialize();
      });
      controller?.setLooping(true);
    } else {
      controller = VideoPlayerController.network(url);
      controller?.initialize().catchError((error) async {
        print(error.toString());
        controller?.initialize();
      });
      controller?.setLooping(true);
      cachedForUrl(url);
    }
  }

  //: check for cache
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value =
        await CustomCacheManager.instance.getFileFromCache(url);
    return value;
  }

//:cached Url Data
  void cachedForUrl(String url) async {
    await CustomCacheManager.instance.getSingleFile(url).then((value) {
      print('downloaded successfully done for $url');
    });
  }

  dispose() async {
    controller?.dispose();
  }
}
