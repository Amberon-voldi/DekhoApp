import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Controlers/AppData/AppdataController.dart';
import 'package:dekho/Controlers/Posts/Post.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/main.dart';

import 'package:dekho/models/ModelProvider.dart';
import 'package:dekho/pages/Activity/PostUploadPage.dart';
import 'package:dekho/widgets/notSignedin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../Controlers/Posts/PostsController.dart';

import '../../widgets/ActivityWidgets/widgets/post_container.dart';

import '../../widgets/ActivityWidgets/widgets/stories.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  final feedViewModel = GetIt.instance<PostsViewModel>();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isSignedin
        ? NotSignedIn()
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: _HomeScreenMobile(
                  scrollController: _trackingScrollController),
            ),
          );
    ;
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final feedViewModel = GetIt.instance<PostsViewModel>();
  final appDataModel = GetIt.instance<AppData>();

  _HomeScreenMobile({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (feedViewModel.posts.isNotEmpty) {
      feedViewModel.posts.sort((a, b) => b.time!.compareTo(a!.time!));
    }

    return Container(
      color: feedViewModel.posts.isEmpty
          ? Colors.black
          : Color.fromARGB(255, 22, 22, 22),
      child: CustomScrollView(
        controller: scrollController,
        // physics: BouncingScrollPhysics(
        //   parent: AlwaysScrollableScrollPhysics(
        //     parent: BouncingScrollPhysics(),
        //   ),
        // ),
        slivers: [
          // SliverAppBar(
          //   backgroundColor: Colors.black,
          //   title: Text(
          //     'Dekho',
          //     style: const TextStyle(
          //       color: Colors.pink,
          //       fontSize: 28.0,
          //       fontWeight: FontWeight.bold,
          //       letterSpacing: -1.2,q
          //     ),
          //   ),
          //   centerTitle: false,
          //   floating: true,
          // ),
          // SliverToBoxAdapter(
          //   child: CreatePostContainer(currentUser: currentUser),
          // ),
          if (guserData != null && appDataModel.isstoryready.isTrue)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Stories(
                  currentUser: guserData!,
                  stories: appDataModel.userstory,
                ),
              ),
            ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (feedViewModel.posts.isEmpty) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 0,
                            ),
                            Icon(
                              UniconsLine.comment,
                              size: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'No Posts available for you, yet',
                              style: GoogleFonts.dmSans(color: Colors.white),
                            )
                          ]),
                    );
                  } else {
                    final PostLocal post = feedViewModel.posts[index];
                    return PostContainer(
                      post: post.post!,
                      postlocal: post,
                    );
                  }
                },
                childCount: feedViewModel.posts.isEmpty
                    ? 1
                    : feedViewModel.posts.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
