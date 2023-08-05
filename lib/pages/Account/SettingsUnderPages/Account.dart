import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/variables.dart';

class SettingsAccount extends StatefulWidget {
  const SettingsAccount({super.key});

  @override
  State<SettingsAccount> createState() => _SettingsAccountState();
}

class _SettingsAccountState extends State<SettingsAccount> {
  @override
  Widget build(BuildContext context) {
    String ampm = guserData!.updatedAt!.getDateTimeInUtc().toUtc().hour > 12
        ? 'PM'
        : 'AM';
    return Scaffold(
      appBar: AppBar(
          title: const Text('Account'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          )),
      body: ListView(children: [
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[800],
              foregroundImage: NetworkImage(
                guserData!.pfp!,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('@' + guserData!.username!,
                style: GoogleFonts.dmSans(fontSize: 13)),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        Divider(
          color: Colors.blueGrey,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Account Information',
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            Text(
                'Some details about your account are stored on our servers besides your personal information to help you access your account and to provide you with a better experience.',
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500)),
          ]),
        ),
        ListTile(
          title: Text('Joined On',
              style: GoogleFonts.dmSans(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          trailing: Text(
              guserData!.createdAt!.getDateTimeInUtc().toUtc().day.toString() +
                  '/' +
                  guserData!.createdAt!
                      .getDateTimeInUtc()
                      .toUtc()
                      .month
                      .toString() +
                  '/' +
                  guserData!.createdAt!
                      .getDateTimeInUtc()
                      .toUtc()
                      .year
                      .toString()!,
              style: GoogleFonts.dmSans(
                  color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
        ListTile(
          title: Text('Last Details Updated On',
              style: GoogleFonts.dmSans(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          trailing: Text(
              guserData!.updatedAt!.getDateTimeInUtc().toUtc().hour.toString() +
                  ':' +
                  guserData!.updatedAt!
                      .getDateTimeInUtc()
                      .toUtc()
                      .minute
                      .toString() +
                  ' ' +
                  ampm +
                  ' ' +
                  guserData!.updatedAt!
                      .getDateTimeInUtc()
                      .toUtc()
                      .day
                      .toString() +
                  '/' +
                  guserData!.updatedAt!
                      .getDateTimeInUtc()
                      .toUtc()
                      .month
                      .toString() +
                  '/' +
                  guserData!.updatedAt!
                      .getDateTimeInUtc()
                      .toUtc()
                      .year
                      .toString(),
              style: GoogleFonts.dmSans(
                  color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          child: Text('Delete Account',
              style: GoogleFonts.dmSans(
                  color: Colors.red, fontWeight: FontWeight.w500)),
          onPressed: () {
            Get.defaultDialog(
                titlePadding: EdgeInsets.only(top: 30),
                contentPadding: EdgeInsets.all(20),
                buttonColor: Colors.red,
                backgroundColor: Color.fromARGB(255, 63, 62, 62),
                title: 'Delete Account',
                content: Text(
                    'Are you sure you want to delete your account? This action cannot be undone.'),
                textConfirm: 'Delete',
                cancelTextColor: Colors.white,
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                },
                textCancel: 'Cancel',
                onCancel: () {});
          },
        ),
      ]),
    );
  }
}
