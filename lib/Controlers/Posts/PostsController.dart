import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Controlers/Posts/Post.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/PostModel.dart';
import '../../models/User.dart';
import '../../widgets/ActivityWidgets/widgets/post_container.dart';

class PostsViewModel {
  // ignore: prefer_final_fields
  // dynamic variable to store posts
  RxList posts = [].obs;
  PostsViewModel() {
    getPosts();
  }

  // Gets all post from dynamodb shrink 2
  // Future<void> your need to use await and async

  getPosts() async {
    final request = ModelQueries.list(PostModel.classType,
        where: PostModel.ISREEL.eq(false));
    final response = await Amplify.API.query(request: request).response;
    final todo = response.data;
    print(todo!.items.length);
    todo.items.forEach((element) async {
      final request = ModelQueries.get(User.classType, element!.userID);
      final response = await Amplify.API.query(request: request).response;
      final user = response.data;
      PostLocal post = PostLocal.fromJson(element!.toJson(), element, user);
      posts.add(post);
    });

    if (posts.length > 0) {
      posts.sort((a, b) => b.time!.compareTo(a!.time!));
    }
  }

  likevideo(
    i,
    PostModel video,
    PostLocal j,
  ) async {
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
      return 'unliked';
    } else {
      k.add(userid);
      j.likesArray = k;
      print(j.likesArray);
      final request =
          ModelMutations.update(video.copyWith(arrayLikes: j.likesArray));
      final response = await Amplify.API.mutate(request: request).response;
      Get.log(response.data.toString());
      return 'liked';
    }
  }

  removeid(id, List<String> list) {
    list.remove(id);
    return list;
  }
}
