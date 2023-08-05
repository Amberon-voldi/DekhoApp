import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/main.dart';
import 'package:dekho/models/ChatContainer.dart';
import 'package:dekho/models/Follow.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/CustomCacheManager.dart';
import '../../models/PostModel.dart';
import '../../models/User.dart';

class AppData {
  List following = [];
  List userstory = [];
  List<String> mp4story = []; //:mp4 story
  List topuser = []; //:top user
  List userposts = []; //:user posts
  List<Follow> followrequests = []; //:user following

  final isstoryready = false.obs;
  AppData() {
    getuserid();
    getSliders();
  }

  getsearch() async {
    // final request = ModelQueries.list(User.classType,
    //     where: User.ACCOUNTTYPE.ne('Private').and(User.COINS.gt(0)));
    final request = ModelQueries.list(
      User.classType,
    );
    final response = await Amplify.API.query(request: request).response;

    final items = response.data!.items;

    topuser.addAll(items);
    try {
      topuser.sort((a, b) => b.coins!.compareTo(a!.coins!));
    } catch (e) {}

    print(topuser.length);
  }

  getUserPosts() async {
    try {
      final request = ModelQueries.list(PostModel.classType,
          where: PostModel.USERID.eq(userid));
      final response = await Amplify.API.query(request: request).response;
      final todo = response.data;
      print(todo!.items.length);
      todo.items.forEach((element) {
        final ac = userposts.any((element2) => element2.id == element!.id);
        if (ac) {
          return;
        }
        userposts.add(element);
      });

      print('got user posts');
      try {
        userposts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } catch (e) {}
    } catch (e) {
      print(e);
    }
  }

  getmediatype(media) {
    if (media.toString().contains('.mp4')) {
      print('video');
      return true;
    } else {
      return false;
    }
  }

  getuserid() async {
    final box = GetStorage();
    final id = box.read('userid');

    userid = id.toString();

    if (id != null) {
      isSignedin = true;
    }

    try {
      if (id == null) {
        return;
      }

      final request = ModelQueries.get(User.classType, id);
      final response = await Amplify.API.query(request: request).response;

      final iserinfo = response.data!;

      userid = iserinfo.id;
      guserData = iserinfo;
      print('Asigned user info');
      getfollowersData();
      getUserPosts();
      getfollowrequests();
    } catch (e) {
      print(e);
    }
  }

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

  checkandchache(url) async {
    try {
      final file = await checkCacheFor(url);
      if (file == null) {
        print('started caching index - $url');
        cachedForUrl(url);
      } else {
        print('already cached index - $url');
      }
    } catch (e) {
      print('error in caching index - $url');
    }
  }

  getfollowersData() async {
    List followingUsers = [];
    final box = GetStorage();
    final followingrequest = ModelQueries.list(Follow.classType,
        where: Follow.FOLLOWEDBY.eq(guserData!.id));
    final followingresponse =
        await Amplify.API.query(request: followingrequest).response;
    final followingtodo = followingresponse.data;
    following.addAll(followingtodo!.items);

    for (var i = 0; i < following.length; i++) {
      final request = ModelQueries.get(
        User.classType,
        following[i]!.following!,
      );
      final response = await Amplify.API.query(request: request).response;
      final todo = response.data;

      followingUsers.add(todo);

      if (todo!.storyUploaded == true) {
        // if (todo.story!.) {
        //   continue;
        // }

        final av = userstory.any((element) => element.id == todo.id);
        if (av == false) {
          userstory.add(todo);
          mp4story.addAll(todo.story!.contentUrl.where(
            (element) => element.contains('.mp4'),
          ));
        }
      }
    }
    if (followingUsers.isNotEmpty) {
      box.write('followingUsers', followingUsers);

      Get.log(followingUsers.length.toString() + 'kmkm');
    }
    print(mp4story);
    if (mp4story.isNotEmpty) {
      mp4story.forEach((element) {
        checkandchache(element);
      });
      isstoryready.value = true;
    }
  }

  getSliders() async {
    final request = ModelQueries.list(SliderModel.classType);
    final response = await Amplify.API.query(request: request).response;
    final todo = response.data;
    Get.log(todo!.items.toString() + 'kmkm');
    final box = GetStorage();
    if (todo!.items.isNotEmpty) {
      box.write('sliders', todo.items);
    }
    // final er = ModelMutations.create(SliderModel(
    //   image: 'https://i.imgur.com/2YQ3X1M.jpg',
    // ));
    // final gg = await Amplify.API.query(request: er).response;
    // final tfodo = gg.data;
    // Get.log(tfodo.toString() + 'kmkm');
  }

  getfollowrequests() async {
    final request = ModelQueries.list(Follow.classType,
        where: Follow.FOLLOWING.eq(userid).and(Follow.ACCEPTED.eq(false)));
    final response = await Amplify.API.query(request: request).response;
    final todo = response.data;
    try {
      todo!.items.forEach((element) {
        final av = followrequests.any((element2) => element2.id == element!.id);
        if (av == false) {
          followrequests.add(element!);
        }
      });
    } catch (e) {}

    Get.log(followrequests.length.toString() + 'kmkm');
    print(followrequests.length);
  }
}
