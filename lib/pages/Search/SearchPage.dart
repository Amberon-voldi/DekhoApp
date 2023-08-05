import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekho/Controlers/Reels/VideoModel.dart';
import 'package:dekho/pages/Account/AccountPage.dart';
import 'package:dekho/pages/Account/FeedViewPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controlers/AppData/AppdataController.dart';
import '../../Controlers/Reels/ReelsVideoController.dart';
import '../../models/ModelProvider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final appdata = GetIt.instance<AppData>();
  final viddata = GetIt.instance<FeedViewModel>();

  @override
  Widget build(BuildContext context) {
    List<Video> vids = viddata.videos;
    vids.sort((a, b) => (b.likesArray != null ? b.likesArray!.length : 0)
        .compareTo(a.likesArray != null ? a.likesArray!.length : 0));
    final box = GetStorage();
    List kj = box.read('sliders') ?? [];
    if (kj.any((element) => element == null)) {
      kj.removeWhere((element) => element == null);
    }
    Get.log(kj.toString());
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'Search',
            style: GoogleFonts.dmSans(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: searchDelegate());
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // make a overley with black color and 0.5 opacity on top of the image
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                      itemCount: kj.length == 0 ? 5 : kj.length,
                      itemBuilder: ((context, index, realIndex) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          color: Colors.pink,
                          child: Image.network(
                            kj.isNotEmpty
                                ? kj[index].image ??
                                    'https://cdn.discordapp.com/attachments/919582268631162883/1066143359061721219/photo_6221840413153670632_x.jpg'
                                : 'https://cdn.discordapp.com/attachments/919582268631162883/1066143359061721219/photo_6221840413153670632_x.jpg',
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 6),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        enlargeFactor: 0.1,
                        scrollDirection: Axis.horizontal,
                      )),
                  // make a black gradient on top of the image to make the text more visible
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildTopUsers(),

            SizedBox(
              height: 10,
            ),
            _buildVideoList('Trending', vids)
          ],
        ));
  }

  Widget _buildVideoList(title, List<Video> list) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.to(() => FeedViewPlayer(
                          video: list[index],
                        )),
                    child: AspectRatio(
                      aspectRatio: 9 / 13,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        child: Stack(children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: list[index].previewimage.toString(),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      list[index].userdetails == null
                                          ? '@' +
                                              list[index].username.toString()
                                          : '@' +
                                              list[index]
                                                  .userdetails!
                                                  .username
                                                  .toString(),
                                      style: GoogleFonts.dmSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  // SizedBox(height: 5),
                                  // Text(list[index].videoTitle.toString(),
                                  //     style: GoogleFonts.dmSans(
                                  //         fontSize: 5,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.white)),
                                ]),
                          )
                        ]),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildTopUsers() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Users',
              style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () => Get.to(() => AccountPage(
                            userData: appdata.topuser[index],
                            doit: false,
                            userid: appdata.topuser[index]!.id!,
                          )),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            foregroundImage:
                                NetworkImage(appdata.topuser[index]!.pfp!),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '@' + appdata.topuser[index]!.username!,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.dmSans(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class searchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
