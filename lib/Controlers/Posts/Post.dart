import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/models/CommentModel.dart';
import 'package:dekho/models/ModelProvider.dart';

import '../../models/LikeModel.dart';

class PostLocal {
  late String id;
  late String? caption;
  late List<String?>? media;
  late List? comments;
  late String? username;
  late User? userData;
  late String? pfp;
  late bool? isCommentDisabled;
  late int? shareCount;
  late List<String>? likesArray;
  late PostModel? post;
  late TemporalDateTime? time;
  late String? userID;

  PostLocal(
      {required this.id,
      this.caption,
      this.userData,
      this.media,
      this.comments,
      this.username,
      this.shareCount,
      this.pfp,
      this.post,
      this.likesArray,
      this.isCommentDisabled,
      required this.userID,
      this.time});

  PostLocal.fromJson(Map<String, dynamic> json, postd, User? user) {
    id = json['id'];
    caption = json['caption'];
    media = json['media'];
    comments = json['comments'];
    likesArray = json['arrayLikes'];
    userID = json['userId'];
    time = TemporalDateTime.fromString(json['time']);
    post = postd;
    shareCount = json['shareCount'];
    isCommentDisabled = json['isCommentDisabled'];
    username = json['username'];
    pfp = json['pfp'];
    userData = user;
  }
}
