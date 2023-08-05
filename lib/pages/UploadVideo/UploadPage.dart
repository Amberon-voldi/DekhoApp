import 'dart:io';
import 'package:flutter/cupertino.dart' as cup;
import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart' as compress;
import 'package:video_player/video_player.dart';

import '../../Controlers/AppData/AppdataController.dart';

class UploadPage extends StatefulWidget {
  File file;
  UploadPage({super.key, required this.file});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

final uploadingVideo = false.obs;

class _UploadPageState extends State<UploadPage> {
  late VideoPlayerController controller;
  TextEditingController captioncontroller = TextEditingController();

  bool ispublic = true;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  bool commentoff = false;
  bool isadult = false;

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Upload',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Center(
            child: Text(
              ispublic ? 'Public' : 'Private',
              style: GoogleFonts.dmSans(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                ispublic = !ispublic;
              });
            },
            icon: Icon(
              ispublic ? Icons.public : Icons.public_off_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: TextField(
                      maxLines: 10,
                      controller: captioncontroller,
                      style: GoogleFonts.dmSans(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Caption',
                        hintStyle: GoogleFonts.dmSans(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        color: Colors.black,
                        width: double.infinity,
                        child: controller.value.isInitialized
                            ? Center(
                                child: AspectRatio(
                                  aspectRatio: controller.value.aspectRatio,
                                  child: VideoPlayer(
                                    controller,
                                  ),
                                ),
                              )
                            : Center(child: CircularProgressIndicator()),
                      )),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.3,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cup.Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Comment Off',
                      style: GoogleFonts.dmSans(color: Colors.white),
                    ),
                    Text(
                      'Turn off comments for this video',
                      style:
                          GoogleFonts.dmSans(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                cup.CupertinoSwitch(
                  activeColor: Colors.pink,
                  value: commentoff,
                  onChanged: (value) {
                    setState(() {
                      commentoff = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cup.Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mature Content?',
                      style: GoogleFonts.dmSans(color: Colors.white),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Turn this on if your video contains mature content eg. violence, profanity etc',
                        textWidthBasis: TextWidthBasis.longestLine,
                        maxLines: 3,
                        style: GoogleFonts.dmSans(
                            color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                cup.CupertinoSwitch(
                  activeColor: Colors.pink,
                  value: isadult,
                  onChanged: (value) {
                    setState(() {
                      isadult = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      try {
                        uploadingVideo.value = true;
                        Get.log('Uploading video');
                        print('Uploading video');
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.pink,
                                )));

                        UploadVideoController().StartCompress(
                            widget.file,
                            captioncontroller.text,
                            ispublic,
                            commentoff,
                            isadult);
                      } catch (e) {
                        uploadingVideo.value = false;
                        Get.back();
                        Get.log(e.toString());
                        Fluttertoast.showToast(
                            msg:
                                'Something went wrong, please try again later');
                      }
                    },
                    child: AutoSizeText(
                      'Upload',
                      style: GoogleFonts.dmSans(color: Colors.white),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadVideoController {
  final appdata = GetIt.instance<AppData>();
  uploadvideotostorage(String id, File file) async {
    try {
      await Amplify.Storage.uploadFile(
        local: file,
        key: 'posts/videos/$id.mp4',
        options: S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );

      final url =
          'https://d2rc0ceaqxuog9.cloudfront.net/public/posts/videos/$id.mp4';

      print(url);
      print('Successfully uploaded file: ');
      return url;
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future getpreviewimage(path) async {
    final previewimage = await compress.VideoCompress.getFileThumbnail(path);

    return previewimage;
  }

  uploadimagetostorage(String id, File file) async {
    try {
      await Amplify.Storage.uploadFile(
        local: await getpreviewimage(file.path),
        key: 'posts/images/$id.jpg',
        options: S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );
      print('Successfully image uploaded file: ');
      final downloadurl =
          'https://d2rc0ceaqxuog9.cloudfront.net/public/posts/images/$id.jpg';
      return downloadurl;
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  StartCompress(File file, caption, isPublic, commentoff, isadult) async {
    var downloadsPath = await getExternalStorageDirectory();
    var datetime = DateTime.now();
    final myImagePath = '${downloadsPath!.path}/Compressor';
    // create folder if not exists
    final myImageFolder = Directory(myImagePath); // set path to folder
    if (!(await myImageFolder.exists())) {
      // if folder not exists, create folder
      await myImageFolder.create();
    }

    var pathOfImage = await File('${myImagePath}/compressed.mp4').create();

    var outpath = pathOfImage.path;
    Get.back();
    Get.back();
    final LightCompressor _lightCompressor = LightCompressor();
    final dynamic response = await _lightCompressor.compressVideo(
        path: file.path,
        videoQuality: VideoQuality.high,
        isMinBitrateCheckEnabled: false,
        video: Video(videoName: 'compressvideo'),
        android: AndroidConfig(isSharedStorage: false, saveAt: SaveAt.Movies),
        ios: IOSConfig(saveInGallery: false));
    if (response is OnSuccess) {
      final String outputFile = response.destinationPath;
      StartUpload(File(outputFile), caption, isPublic, commentoff, isadult);
    } else if (response is OnFailure) {
      // failure message
      print(response.message);
    } else if (response is OnCancelled) {
      print(response.isCancelled);
    }
  }

  StartUpload(File file, String caption, bool isPulic, bool commentoff,
      bool isadult) async {
    final uuid = Uuid();

    var id = uuid.v4().toString();
    String video = await uploadvideotostorage(id, file);
    String previewimage = await uploadimagetostorage(id, file);

    final item = PostModel(
        id: id,
        videourl: video,
        isCommentDisabled: commentoff,
        previewimage: previewimage,
        caption: caption,
        comments: [],
        pfp: guserData!.pfp,
        username: guserData!.username,
        isReel: true,
        isAdultContent: isadult,
        time: TemporalDateTime.now(),
        isPublic: isPulic,
        userID: userid);
    final request = ModelMutations.create(item);
    final response = await Amplify.API.mutate(request: request).response;

    final createdTodo = response.data;
    uploadingVideo.value = false;
    Get.log('Video uploaded');
    Get.snackbar('Hey!', 'Your Video Was Uploaded Successfully');
    appdata.userposts.add(createdTodo);
    if (createdTodo == null) {
      safePrint('errors: ${response.errors}');
      return;
    }
  }
}
