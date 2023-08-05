import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekho/pages/Activity/StoryPage.dart';
import 'package:dekho/pages/Activity/UploadStory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../Controlers/AppData/AppdataController.dart';
import '../../../models/User.dart';
import 'profile_avatar.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List stories;
  final appDataModel = GetIt.instance<AppData>();

  Stories({
    Key? key,
    required this.currentUser,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(stories);
    return Container(
      height: 100.0,
      color: Colors.black,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                  onTap: () {
                    Get.to(() => StoryCam());
                  },
                  child:
                      _StoryCard(isAddStory: true, currentUser: currentUser)),
            );
          }

          if (stories.isNotEmpty ||
              stories != null ||
              stories != [] && appDataModel.isstoryready.isTrue) {
            final story = stories[index - 1];

            // return Container();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _StoryCard(
                story: story,
                isAddStory: false,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User? currentUser;
  final User? story;

  const _StoryCard({
    Key? key,
    required this.isAddStory,
    this.currentUser,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAddStory
        ? Stack(
            children: [
              CachedNetworkImage(
                imageUrl: currentUser!.pfp!,
                imageBuilder: (context, imageProvider) => Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.pink,
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => StoryPage(), arguments: story);
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.pink, width: 2)),
                  padding: EdgeInsets.all(3),
                  child: CachedNetworkImage(
                    imageUrl: story!.pfp!,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
