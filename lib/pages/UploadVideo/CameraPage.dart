import 'package:camera/camera.dart';
import 'package:custom_gallery_display/custom_gallery_display.dart';
import 'package:dekho/pages/UploadVideo/PreviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dekho/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  @override
  void initState() {
    super.initState();
    // hide the task bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.black));
    }
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              CameraPreview(controller),
              // make snapchat camera page ui

              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.browse_gallery,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.circle,
                            size: 100,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.black)),
    );
  }
}

class Cam extends StatelessWidget {
  const Cam({super.key});

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
            () => PreviewPage(
              file: selectedFile,
            ),
          );
        });
  }
}
