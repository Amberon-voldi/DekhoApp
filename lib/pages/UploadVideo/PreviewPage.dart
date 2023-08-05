import 'dart:io';

import 'package:dekho/pages/UploadVideo/UploadPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  File file;
  PreviewPage({super.key, required this.file});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
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
            'Preview',
            style: TextStyle(color: Colors.white),
          ),
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
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Get.off(
                      () => UploadPage(
                        file: widget.file,
                      ),
                    );
                  },
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ));
  }
}
