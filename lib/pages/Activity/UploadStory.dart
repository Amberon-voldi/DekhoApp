import 'dart:io';

import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:custom_gallery_display/custom_gallery_display.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/UserStory.dart';
import 'package:dekho/pages/UploadVideo/UploadPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class UploadStoryPage extends StatefulWidget {
  File file;
  UploadStoryPage({super.key, required this.file});

  @override
  State<UploadStoryPage> createState() => _UploadStoryPageState();
}

class _UploadStoryPageState extends State<UploadStoryPage> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {
          controller.play();
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Story',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.add_a_photo, color: Colors.white),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: Stack(
          children: [
            Container(
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
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
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

                      var id = Uuid().v4().toString();
                      String video =
                          await uploadvideotostorage(id, widget.file);
                      // String image = await uploadimagetostorage(id, file);

                      final item = guserData!.copyWith(
                          storyUploaded: true,
                          story: UserStory(
                            contentUrl: [
                              ...guserData!.story!.contentUrl,
                              video
                            ],
                          ));
                      final request = ModelMutations.update(item);
                      final response =
                          await Amplify.API.mutate(request: request).response;

                      final createdTodo = response.data;
                      guserData = createdTodo;
                      print(guserData);
                      uploadingVideo.value = false;

                      Get.back();
                      Get.back();
                      Get.log('Story uploaded');
                      Get.snackbar(
                          'Hey!', 'Your Story Was Uploaded Successfully');

                      if (createdTodo == null) {
                        safePrint('errors: ${response.errors}');
                        return;
                      }
                    } catch (e) {
                      uploadingVideo.value = false;
                      Get.back();
                      Get.log(e.toString());
                      Fluttertoast.showToast(
                          msg: 'Something went wrong, please try again later');
                    }
                  },
                  child: Text('Upload Story',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ));
  }

  uploadvideotostorage(String id, File file) async {
    try {
      await Amplify.Storage.uploadFile(
        local: file,
        key: 'users/story/${guserData!.id}/$id.mp4',
        options: S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );

      final url =
          'https://d2rc0ceaqxuog9.cloudfront.net/public/users/story/${guserData!.id}/$id.mp4';

      print(url);
      print('Successfully uploaded file: ');
      return url;
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  uploadimagetostorage(String id, File file) async {
    try {
      await Amplify.Storage.uploadFile(
        local: file,
        key: 'users/story/${guserData!.id}/$id.jpg',
        options: S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );
      print('Successfully image uploaded file: ');
      final downloadurl =
          'https://d2rc0ceaqxuog9.cloudfront.net/public/users/story/${guserData!.id}/$id.jpg';
      return downloadurl;
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }
}

class StoryCam extends StatelessWidget {
  const StoryCam({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGalleryDisplay.normalDisplay(
        displaySource: DisplaySource.gallery,
        pickerSource: PickerSource.video,
        galleryDisplaySettings: GalleryDisplaySettings(
          appTheme:
              AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.7,
            mainAxisSpacing: 1.5,
            childAspectRatio: .5,
          ),
        ),
        multiSelection: false,
        onDone: (SelectedImagesDetails details) async {
          final selectedFile = await details.selectedFiles.first.selectedFile;

          double aspectRatio = details.aspectRatio;
          var filesize = await selectedFile.length();
          if (filesize > 7500000) {
            Fluttertoast.showToast(
                msg: "File size should be less than 8 MB",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return;
          }

          Get.off(
            () => UploadStoryPage(
              file: selectedFile,
            ),
          );
        });
  }
}
