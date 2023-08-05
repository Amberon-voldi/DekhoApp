import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekho/Controlers/Posts/Post.dart';
import 'package:dekho/Controlers/Posts/PostsController.dart';
import 'package:dekho/Utils/CommentSheetModel.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:dekho/pages/Account/AccountPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:unicons/unicons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../Controlers/Reels/ReelsVideoController.dart';
import 'profile_avatar.dart';

class FullScreenSlider extends StatelessWidget {
  const FullScreenSlider({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    RxInt index = 0.obs;

    final post = Get.arguments;
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: post.media!.length,
                itemBuilder: ((context, index, realIndex) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                      child: CachedNetworkImage(
                        imageUrl: post.media![index],
                        fit: BoxFit.contain,
                      ));
                }),
                options: CarouselOptions(
                  onPageChanged: (ind, reason) {
                    index.value = ind;
                    print(index.value);
                  },
                  onScrolled: (value) {
                    print(value);
                    index.value = value!.toInt();
                  },
                  viewportFraction: 1.0,
                  aspectRatio: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  height: double.infinity,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  enlargeFactor: 0.1,
                  scrollDirection: Axis.horizontal,
                )),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
                height: 20,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: post.media!.length,
                    itemBuilder: ((context, indx) {
                      return Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.circle,
                              color: index.value == indx
                                  ? Colors.pink
                                  : Colors.white,
                              size: 10),
                        ),
                      );
                    }),
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}

class PostContainer extends StatelessWidget {
  final PostModel post;
  final PostLocal postlocal;

  const PostContainer({
    Key? key,
    required this.post,
    required this.postlocal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();

    RxInt index = 0.obs;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 0.0,
      ),
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: postlocal),
                  const SizedBox(height: 4.0),
                  RichTextView(
                      text: post.caption ?? ' ',
                      textAlign: TextAlign.start,
                      truncate: false,
                      style: GoogleFonts.dmSans(color: Colors.white),
                      linkStyle: GoogleFonts.dmSans(
                          color: Colors.pink,
                          decorationColor: Colors.pink,
                          decoration: TextDecoration.underline),
                      supportedTypes: [
                        EmailParser(
                            onTap: (email) =>
                                launchUrlString('mailto:${email.value}')),
                        PhoneParser(
                            onTap: (phone) =>
                                launchUrlString('tel:${phone.value}')),
                        UrlParser(
                            onTap: (url) => launchUrlString('${url.value}')),
                      ]),
                  post.media != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.media == null || post.media!.isEmpty || post.media!.length == 0
                ? const SizedBox.shrink()
                : post.media!.length == 1
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                        child: CachedNetworkImage(imageUrl: post.media!.first!),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Get.dialog(FullScreenSlider(), arguments: post);
                              },
                              child: CarouselSlider.builder(
                                  carouselController: carouselController,
                                  itemCount: post.media!.length,
                                  itemBuilder: ((context, index, realIndex) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 10,
                                        color: Colors.black,
                                        child: CachedNetworkImage(
                                          imageUrl: post.media![index]!,
                                          fit: BoxFit.contain,
                                        ));
                                  }),
                                  options: CarouselOptions(
                                    onPageChanged: (ind, reason) {
                                      index.value = ind;
                                      print(index.value);
                                    },
                                    onScrolled: (value) {
                                      print(value);
                                      index.value = value!.toInt();
                                    },
                                    viewportFraction: 1.0,
                                    aspectRatio: 1.0,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: false,
                                    enlargeFactor: 0.1,
                                    scrollDirection: Axis.horizontal,
                                  )),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                  height: 20,
                                  child: Center(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: post.media!.length,
                                      itemBuilder: ((context, indx) {
                                        return Obx(
                                          () => Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            child: Icon(Icons.circle,
                                                color: index.value == indx
                                                    ? Colors.pink
                                                    : Colors.white,
                                                size: 10),
                                          ),
                                        );
                                      }),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
              child: PostStat(
                post: post,
                postlocal: postlocal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final PostLocal post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () => Get.to(() => AccountPage(
                  userid: post.userID ?? post.userData!.id,
                  doit: false,
                  userData: post.userData,
                )),
            child: ProfileAvatar(
              imageUrl: post.userData != null
                  ? post.userData!.pfp.toString()
                  : post.pfp!,
            )),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.userData != null
                    ? post.userData!.username.toString()
                    : post.username!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${timeago.format(post.time!.getDateTimeInUtc())} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        // IconButton(
        //   icon: const Icon(Icons.more_horiz),
        //   onPressed: () => print('More'),
        // ),
      ],
    );
  }
}

class PostStat extends StatefulWidget {
  final PostModel post;
  final PostLocal postlocal;
  PostStat({super.key, required this.post, required this.postlocal});

  @override
  State<PostStat> createState() => _PostStatState();
}

class _PostStatState extends State<PostStat> {
  final postmodel = GetIt.instance<PostsViewModel>();

  @override
  Widget build(BuildContext context) {
    final jn = widget.postlocal.likesArray ?? [];

    int likes = jn.isEmpty
        ? 0
        : int.parse(widget.postlocal.likesArray!.length.toString());

    final isliked = jn.contains(userid);
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '$likes Likes',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${widget.post.comments == null ? 0 : widget.post.comments.length} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${widget.post.shareCount ?? 0} Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _PostButton(
              icon: isliked
                  ? Icon(
                      UniconsLine.thumbs_up,
                      color: Colors.pink,
                      size: 25.0,
                    )
                  : Icon(
                      UniconsLine.thumbs_up,
                      color: Colors.white,
                      size: 25.0,
                    ),
              label: 'Like',
              onTap: () async {
                await postmodel.likevideo(
                    widget.post.id, widget.post, widget.postlocal);
                setState(() {});
              },
            ),
            _PostButton(
              icon: Icon(
                UniconsLine.comment,
                color: Colors.white,
                size: 25.0,
              ),
              label: 'Comment',
              onTap: () => commentSheetModel(
                  widget.post.id,
                  widget.post.comments,
                  widget.post.isCommentDisabled ?? false,
                  widget.post),
            ),
            _PostButton(
                icon: Icon(
                  UniconsLine.share,
                  color: Colors.white,
                  size: 25.0,
                ),
                label: 'Share',
                onTap: () => FlutterShare.share(
                    title: 'Share Dekho',
                    text: 'Share Dekho',
                    linkUrl:
                        'https://play.google.com/store/apps/details?id=com.mythics.dekho'))
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final dynamic onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          height: 25.0,
          child: icon,
        ),
      ),
    );
  }
}
