import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import 'package:story/story.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/CustomCacheManager.dart';
import '../../models/User.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final User story = Get.arguments;

  getmediatype(media) {
    if (media.toString().contains('.mp4')) {
      print('video');
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        indicatorDuration: Duration(seconds: 30),
        itemBuilder: (context, pageIndex, storyIndex) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Positioned.fill(
                child: getmediatype(story.story!.contentUrl[storyIndex])
                    ? StoryVideoPage(url: story.story!.contentUrl[storyIndex])
                    : Image.network(
                        story.story!.contentUrl[storyIndex],
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(story.pfp!),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      story.username!,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          );
        },
        pageLength: 1,
        storyLength: (int pageIndex) {
          return story.story!.contentUrl.length;
        },
        onPageLimitReached: () {
          print(Get.currentRoute);
          if (Get.currentRoute == '/StoryPage') {
            Get.back();
          }
        },
      ),
    );
  }
}

class StoryVideoPage extends StatefulWidget {
  String url;

  StoryVideoPage({super.key, required this.url});

  @override
  State<StoryVideoPage> createState() => _StoryVideoPageState();
}

class _StoryVideoPageState extends State<StoryVideoPage> {
  late VideoPlayerController controller;
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value =
        await CustomCacheManager.instance.getFileFromCache(url);
    return value;
  }

  getfileandstartvideo() async {
    var file = await checkCacheFor(widget.url);
    controller = VideoPlayerController.file(file!.file)
      ..initialize()
      ..play().then((value) => isplaying.value = true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfileandstartvideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final isplaying = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: isplaying.value == true
            ? VideoPlayer(controller)
            : Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
      ),
    );
  }
}
