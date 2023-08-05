import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_gallery_display/custom_gallery_display.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

import '../../Controlers/AppData/AppdataController.dart';

class PostUploadPage extends StatefulWidget {
  const PostUploadPage({super.key});

  @override
  State<PostUploadPage> createState() => _PostUploadPageState();
}

List<SelectedByte> _images = [];
final isphotoupdated = false.obs;

class _PostUploadPageState extends State<PostUploadPage> {
  TextEditingController _captionController = TextEditingController();
  final appdata = GetIt.instance<AppData>();
  isFormvalited() {
    if (_captionController.text.isEmpty && _images.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Create Post', style: GoogleFonts.dmSans(color: Colors.white)),
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: (() {
                  if (isFormvalited()) {
                    uploadpost();
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please write or select a photo',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }),
                child: Text('Post',
                    style: GoogleFonts.dmSans(color: Colors.white))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _captionController,
                maxLines: 15,
                onChanged: (value) {
                  if (mounted) setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  hintStyle: GoogleFonts.dmSans(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                isphotoupdated.value = false;
                Get.to(() => PickImages());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.photo,
                        color: Colors.blue,
                      )),
                  Text('Photo', style: GoogleFonts.dmSans(color: Colors.blue))
                ],
              ),
            ),
            _buildImageList()
          ],
        ),
      ),
    );
  }

  uploadimagetostorage(String id, File file) async {
    try {
      await Amplify.Storage.uploadFile(
        local: file,
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

  uploadpost() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ));
    if (_images.isNotEmpty) {
      var links = <String>[];
      var id = Uuid().v4();
      for (var i = 0; i < _images.length; i++) {
        final downloadurl =
            await uploadimagetostorage('$id-$i', _images[i].selectedFile);
        links.add(downloadurl);
      }
      final todo = PostModel(
          id: id,
          comments: [],
          isReel: false,
          caption: _captionController.text,
          time: TemporalDateTime.now(),
          pfp: guserData!.pfp,
          username: guserData!.username,
          media: links,
          userID: userid);
      final request = ModelMutations.create(todo);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTodo = response.data;
      Get.back();
      Get.back();
      Get.snackbar('Hey!', 'Your post has been uploaded');
      appdata.userposts.add(createdTodo);
    } else {
      final todo = PostModel(
          id: Uuid().v4(),
          isReel: false,
          comments: [],
          time: TemporalDateTime.now(),
          caption: _captionController.text,
          pfp: guserData!.pfp,
          username: guserData!.username,
          userID: userid);
      final request = ModelMutations.create(todo);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTodo = response.data;

      Get.back();
      Get.back();
      Get.snackbar('Hey!', 'Your post has been uploaded');
      appdata.userposts.add(createdTodo);
    }
  }

  Widget _buildImageList() {
    return Obx(() => Container(
          height: 130,
          child: isphotoupdated.value
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 120,
                      width: 120,
                      child: Image.file(
                        _images[index].selectedFile,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
              : Container(),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _images.clear();
    super.dispose();
  }
}

class PickImages extends StatelessWidget {
  const PickImages({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGalleryDisplay.normalDisplay(
        displaySource: DisplaySource.both,
        pickerSource: PickerSource.image,
        galleryDisplaySettings: GalleryDisplaySettings(
          appTheme:
              AppTheme(focusColor: Colors.blue, primaryColor: Colors.black),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.7,
            mainAxisSpacing: 1.5,
            childAspectRatio: 1.0,
          ),
        ),
        multiSelection: true,
        onDone: (SelectedImagesDetails details) async {
          final selectedFile = details.selectedFiles;

          double aspectRatio = details.aspectRatio;
          _images.addAll(selectedFile);
          isphotoupdated.value = true;

          Get.back();
        });
  }
}
