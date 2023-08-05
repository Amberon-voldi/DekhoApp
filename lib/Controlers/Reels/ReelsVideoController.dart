import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:math';
import 'package:dekho/main.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart' as datastore;
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Controlers/Reels/VideoModel.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/LikeModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../Utils/CustomCacheManager.dart';
import '../../models/PostModel.dart';
import '../../models/User.dart';

int? adindex;

class FeedViewModel extends BaseViewModel {
  // VideoPlayerController? controller;
  List<Video> videos = [];

  int prevVideo = 0;

  int videoslimit = 100;
  int currentVideo = 0;

  PaginatedResult<PostModel>? nextpagedata;

  bool gettingmorepost = false;
  bool morepostavl = true;

  FeedViewModel() {}

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

  checkandchache(index) async {
    try {
      print(videos[index].id + videos[index].url);
      final file = await checkCacheFor(videos[index].url);
      if (file == null) {
        print('started caching index - $index');
        cachedForUrl(videos[index].url);
      } else {
        print('already cached index - $index');
      }
    } catch (e) {
      print('error in caching index - $index');
    }
  }

  load() async {
    videos = await getVideoList();
    print(videos);

    await videos[0].loadController().then((value) {
      checkandchache(1);
      checkandchache(2);
      checkandchache(3);
      checkandchache(4);
      checkandchache(5);
      checkandchache(6);
      checkandchache(7);
    });

    await videos[1].loadController();
    await videos[2].loadController();
    notifyListeners();
  }

  playv() {
    videos[prevVideo].controller!.play();

    notifyListeners();
  }

  pause() {
    videos[prevVideo].controller!.pause();

    notifyListeners();
  }

  var isplaying = true.obs;

  Future<List<Video>> getVideoList() async {
    var videoList = <Video>[];
    int random(min, max) {
      return min + Random().nextInt(max - min);
    }

    Iterable videositem = [];
    videoList = <Video>[];
    var jh;

    final request = ModelQueries.list<PostModel>(
      PostModel.classType,
      where: PostModel.ISREEL.eq(true),
    );
    final response = await Amplify.API.query(request: request).response;
    final res = response.data;
    print(res!.items);
    nextpagedata = res;

    // sort by time

    // print("PostModel Videos fected = " + res!.items.length.toString());
    jh = res.items;
    prevVideo = 0;

    jh.shuffle();

    videositem = jh;

    Get.log(videositem.length.toString() + " videos loadedd");
    videositem.forEach((element) async {
      Video video = Video.fromJson(element.toJson(), element, null);
      print(video.id + video.url);
      videoList.add(video);
    });
    adduserdatawithindex(0, videoList[0].userID);
    adduserdatawithindex(1, videoList[1].userID);
    adduserdatawithindex(2, videoList[2].userID);

    videoList.shuffle();
    Get.log(videoList.length.toString() + " videos loaded");
    return videoList;
  }

  adduserdatawithindex(index, id) async {
    try {
      if (videos.any((element) => element.userdetails!.id == id)) {
        Video j =
            videos.where((element) => element.userdetails!.id == id).first;
        videos[index].userdetails = j.userdetails;
        print("user copyed added ${videos[index].userdetails!.id}");
        return;
      } else {
        final request = ModelQueries.get(User.classType, id);
        final response = await Amplify.API.query(request: request).response;
        final todo = response.data;
        videos[index].userdetails = todo;
        print("user data added ${videos[index].userdetails!.id}");
      }
    } catch (e) {
      final request = ModelQueries.get(User.classType, id);
      final response = await Amplify.API.query(request: request).response;
      final todo = response.data;
      videos[index].userdetails = todo;
      print("user data added after error ${videos[index].userdetails!.id}");
    }
  }

  Future<void> getmorevideos() async {
    Get.log('getmorevideos');
    if (morepostavl == false) {
      Get.log('no more posts - getmorevideos');
      return;
    }

    if (gettingmorepost == true) {
      return;
    }
    Iterable videositem = [];
    var videolist = <Video>[];
    Get.log('${nextpagedata!.hasNextResult} - getmorevideos');
    try {
      if (nextpagedata?.hasNextResult ?? false) {
        final secondRequest = nextpagedata!.requestForNextResult;
        final secondResult =
            await Amplify.API.query(request: secondRequest!).response;
        final jh = secondResult.data!.items;
        nextpagedata = secondResult.data;
        if (jh.isEmpty) {
          Get.log('filtered no more posts - getmorevideos');
          return;
        }
        videositem = jh.map((e) => e!.toJson());
        print(videositem);

        videositem.forEach((element) {
          if (videos.any((eleme) => eleme.id == element['id'])) {
            return;
          }
          Video video =
              Video.fromJson(element, PostModel.fromJson(element), null);
          Get.log(video.id + video.url + ' - getmorevideos');

          videos.add(video);
        });

        print('more PostModel videos requested total = ' +
            videos.length.toString());

        gettingmorepost = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  changeVideo(
    index,
    bool Direction,
  ) async {
    if (Direction) {
      try {
        if (videos[prevVideo].controller != null) {
          videos[prevVideo].controller!.pause();
        }
      } catch (e) {}

      if (videos[index].controller == null) {
        await videos[index].loadController();
      }
      try {
        if (videos[prevVideo - 1].controller != null) {
          videos[prevVideo - 1].controller!.dispose();
          videos[prevVideo - 1].controller = null;
        }
      } catch (e) {}
      if (index != adindex) {
        if (prevVideo == index - 1) {
          videos[index].controller!
            ..setLooping(true)
            ..play().then((value) {
              notifyListeners();
            });
        }
      }

      prevVideo = index;

      try {
        await videos[prevVideo + 1].loadController();
      } catch (e) {}
      // try {
      //   await videos[prevVideo + 2].loadController();
      // } catch (e) {}

      // try {
      //   if (videos[prevVideo + 2].controller == null) {
      //     await videos[prevVideo + 2].loadController();
      //   }
      // } catch (e) {}
      notifyListeners();
      try {
        if (videos[prevVideo + 1].controller == null) {
          await videos[prevVideo + 1].loadController();
        }
      } catch (e) {}

      try {
        if (videos[prevVideo + 2].userdetails == null) {
          adduserdatawithindex(prevVideo + 2, videos[prevVideo + 2].userID);
        }
      } catch (e) {}

      checkandchache(index + 5);
      checkandchache(index + 10);
    } else if (!Direction) {
      try {
        if (videos[index + 1].controller != null) {
          videos[index + 1].controller!.pause();
        }
      } catch (e) {}

      if (videos[index].controller == null) {
        await videos[index].loadController();
        notifyListeners();
      }

      try {
        if (videos[index + 2].controller != null) {
          videos[index + 2].controller!.dispose();
          videos[index + 2].controller = null;
        }
      } catch (e) {}

      if (index != adindex) {
        videos[index].controller!
          ..setLooping(true)
          ..play().then((value) {
            notifyListeners();
          });
      }
      notifyListeners();

      prevVideo = index;

      try {
        await videos[index - 1].loadController();
      } catch (e) {}
      // if (index > 5) {
      //   checkandchache(index + 5);
      //   checkandchache(index + 10);
      // }

      print(index);
    }
  }

  void loadVideo(int index) async {
    if (videos[index].controller == null) {
      await videos[index].loadController().then(((value) {}));
    }
  }

  addid(id, List<String> list) {
    list.add(id);
    return list;
  }

  removeid(id, List<String> list) {
    list.remove(id);
    return list;
  }

  void likevideo(i, PostModel video, Video j) async {
    var id = i;
    List<String> k = j.likesArray ?? [];
    if (k.contains(userid)) {
      bool kk = k.remove(userid);
      j.likesArray = k;
      print(j.likesArray);
      final request =
          ModelMutations.update(video.copyWith(arrayLikes: j.likesArray));
      final response = await Amplify.API.mutate(request: request).response;
      Get.log(response.data.toString());
    } else {
      k.add(userid);
      j.likesArray = k;
      print(j.likesArray);
      final request =
          ModelMutations.update(video.copyWith(arrayLikes: j.likesArray));
      final response = await Amplify.API.mutate(request: request).response;
      Get.log(response.data.toString());
    }
  }

  // void disposevideo(int previndex, int index, int nextindex) {
  //   try {
  //     videos[index].controller!.dispose();
  //     print('Forced disposed, Controller at index - ${index}');
  //   } catch (e) {
  //     print('failed to dispose player index');
  //   }

  //   try {
  //     if (videos[nextindex].controller != null) {
  //       videos[nextindex].controller!.dispose();

  //       print('Forced disposed, Controller at index - ${index + 1}');
  //     }
  //   } catch (e) {
  //     print('failed to dispose player index +1');
  //     return;
  //   }
  //   try {
  //     if (videos[index + 2].controller != null) {
  //       videos[index + 2].controller!.dispose();

  //       print('Forced disposed, Controller at index - ${index + 2}');
  //     }
  //   } catch (e) {
  //     print('failed to dispose player index +2');
  //     return;
  //   }
  //   try {
  //     if (videos[previndex].controller != null) {
  //       videos[previndex].controller!.dispose();
  //       print('Forced disposed, Controller at index - ${previndex}');
  //     }
  //   } catch (e) {
  //     print('failed to dispose player index -1');
  //     return;
  //   }
  //   try {
  //     if (videos[index - 2].controller != null) {
  //       videos[index - 2].controller!.dispose();
  //       print('Forced disposed, Controller at index - ${index - 2}');
  //     }
  //   } catch (e) {
  //     print('failed to dispose player index - 2');
  //     return;
  //   }
  //   feedViewModel.videos.clear();

  //   notifyListeners();
  // }
}
