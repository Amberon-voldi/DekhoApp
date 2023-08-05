import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:dekho/pages/Account/SettingsUnderPages/PersonalInfoSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/User.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;
  final TextEditingController _nameController =
      TextEditingController(text: guserData!.name);
  final TextEditingController _usernameController =
      TextEditingController(text: guserData!.username);
  final TextEditingController _bioController = TextEditingController(
      text: guserData!.bio == null || guserData!.bio == ''
          ? 'No Bio'
          : guserData!.bio);
  String? gender = guserData!.gender == null ? 'none' : guserData!.gender;

  uploadimagetostorage(String id, File file) async {
    try {
      await Amplify.Storage.uploadFile(
        local: file,
        key: 'avatar/$id.jpg',
        options: S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );
      print('Successfully image uploaded file: ');
      final downloadurl =
          'https://d2rc0ceaqxuog9.cloudfront.net/public/avatar/$id.jpg';
      return downloadurl;
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close_rounded, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (isavailabel.isFalse) {
                Fluttertoast.showToast(msg: 'Username not available');
                return;
              }
              if (_nameController.text == guserData!.name &&
                  _bioController.text == guserData!.bio &&
                  _bioController.text.isEmpty &&
                  _usernameController.text.isEmpty &&
                  _image == null &&
                  gender == guserData!.gender.toString()) {
                Fluttertoast.showToast(msg: 'No Changes Made');
                return;
              }
              Get.dialog(const Center(
                child: CircularProgressIndicator(color: Colors.pink),
              ));
              String pfpurl = '';
              if (_image != null) {
                pfpurl = await uploadimagetostorage(
                    guserData!.id, File(_image!.path));
              }

              final item = guserData!.copyWith(
                  pfp: _image != null ? pfpurl : guserData!.pfp,
                  username: _usernameController.text == guserData!.username ||
                          _usernameController.text == ''
                      ? guserData!.username
                      : _usernameController.text,
                  bio: _bioController.text == guserData!.bio ||
                          _bioController.text.isEmpty
                      ? guserData!.bio
                      : _bioController.text,
                  name: _nameController.text == guserData!.name ||
                          _nameController.text == ''
                      ? guserData!.name
                      : _nameController.text,
                  nameLowerCase: _nameController.text == guserData!.name ||
                          _nameController.text == ''
                      ? guserData!.name!.toLowerCase()
                      : _nameController.text.toLowerCase(),
                  gender: gender == guserData!.gender || gender == 'none'
                      ? guserData!.gender
                      : gender);

              final request = ModelMutations.update(item);
              final response =
                  await Amplify.API.mutate(request: request).response;
              Get.log(response.data.toString());
              if (response.data != null) {
                guserData = response.data;
                Get.back();
                Get.back();
                Fluttertoast.showToast(msg: 'Changes Updated');
              } else {
                Get.back();
                Get.back();
                Fluttertoast.showToast(msg: 'Something went wrong');
              }
            },
            icon: Icon(Icons.check, color: Colors.pink),
          ),
        ],
        title: Text(
          'Edit Profile',
          style: GoogleFonts.dmSans(),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(children: [
        SizedBox(height: 20),
        Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _image == null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[800],
                      foregroundImage: NetworkImage(guserData!.pfp!),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[800],
                      foregroundImage: FileImage(File(_image!.path)),
                    ),
              TextButton(
                  onPressed: (() async {
                    final im = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {
                      _image = im;
                    });
                  }),
                  child: Text(
                    'Change Profile Picture',
                    style: GoogleFonts.dmSans(color: Colors.pink),
                  )),
            ],
          ),
        ),
        SizedBox(height: 20),
        _buildTextField('Full Name', 'Full Name', _nameController),
        _buildUsernameField('Username', 'Username', _usernameController),
        _buildTextField('Bio', 'Bio', _bioController),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gender',
                  style: GoogleFonts.dmSans(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.left),
              Row(children: [
                OutlinedButton(
                    onPressed: (() {
                      setState(() {
                        gender = 'Male';
                      });
                    }),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.male, color: Colors.white),
                        Text(
                          'Male',
                          style: GoogleFonts.dmSans(color: Colors.white),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor:
                            gender == 'Male' ? Colors.pink : Colors.transparent,
                        side: BorderSide(color: Colors.white))),
                SizedBox(width: 10),
                OutlinedButton(
                    onPressed: (() {
                      setState((() {
                        gender = 'Female';
                      }));
                    }),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.female, color: Colors.white),
                        Text(
                          'Female',
                          style: GoogleFonts.dmSans(color: Colors.white),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: gender == 'Female'
                            ? Colors.pink
                            : Colors.transparent,
                        side: BorderSide(color: Colors.white)))
              ]),
              SizedBox(height: 15),
              InkWell(
                onTap: () => Get.to(() => PersonalInfoSettings()),
                child: Row(
                  children: [
                    Text('Edit Personal Information ',
                        style: GoogleFonts.dmSans(
                            color: Colors.pink, fontSize: 15),
                        textAlign: TextAlign.left),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.pink,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController editingController,
  ) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(color: Colors.white),
            labelStyle:
                GoogleFonts.dmSans(color: Color.fromARGB(255, 180, 179, 179)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
            ),
          ),
          style: GoogleFonts.dmSans(color: Colors.white),
          cursorColor: Colors.pink,
          controller: editingController,
        ));
  }

  final isavailabel = true.obs;
  Widget _buildUsernameField(
    String label,
    String hint,
    TextEditingController editingController,
  ) {
    return Obx(
      () => Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onEditingComplete: () async {
              if (editingController.text != guserData!.username ||
                  editingController.text != '') {
                final request = ModelQueries.list(User.classType,
                    where: User.USERNAME.eq(editingController.text));
                final reponse =
                    await Amplify.API.query(request: request).response;
                if (reponse.data!.items.isNotEmpty) {
                  isavailabel.value = false;
                  Get.log('Username is not available');
                } else {
                  isavailabel.value = true;
                  Get.log('Username is available');
                }
              }
            },
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: Icon(
                isavailabel.isTrue ? Icons.check : Icons.close,
                color: isavailabel.isTrue ? Colors.green : Colors.red,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.dmSans(color: Colors.white),
              labelStyle:
                  GoogleFonts.dmSans(color: Color.fromARGB(255, 180, 179, 179)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
            style: GoogleFonts.dmSans(color: Colors.white),
            cursorColor: Colors.pink,
            controller: editingController,
          )),
    );
  }
}
