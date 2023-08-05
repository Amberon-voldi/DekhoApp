import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Auth/AuthHero.dart';

import 'package:dekho/Utils/variables.dart';
import 'package:dekho/main.dart';
import 'package:dekho/pages/Account/SettingsUnderPages/Account.dart';
import 'package:dekho/pages/Account/SettingsUnderPages/PersonalInfoSettings.dart';
import 'package:dekho/pages/Account/SettingsUnderPages/ReferPage.dart';
import 'package:dekho/pages/Account/SettingsUnderPages/Wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mailto/mailto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var ispublic = guserData!.accountType == 'Public' ? true.obs : false.obs;
    var isstatusallowd = guserData!.showActivityStatus.obs;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListTile(
            onTap: () => Get.to(() => PersonalInfoSettings()),
            leading: Icon(Icons.account_box, color: Colors.white),
            title: Text('Personal Info', style: TextStyle(color: Colors.white)),
            subtitle: Text('Edit your personal information',
                style: TextStyle(color: Colors.grey[400])),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () => Get.to(() => WalletPage()),
            leading: Icon(Icons.wallet, color: Colors.white),
            title: Text('Wallet', style: TextStyle(color: Colors.white)),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () => Get.to(() => ReferPage()),
            leading: Icon(Icons.share, color: Colors.white),
            title: Text('Share & Earn', style: TextStyle(color: Colors.white)),
            subtitle: Text('Invite your friends to earn coins',
                style: TextStyle(color: Colors.grey[400])),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () {
              Get.dialog(Scaffold(
                appBar: AppBar(
                  title: Text('Privacy'),
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                body: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        'You can choose to make your account public\n' +
                            'or private. Public accounts can be seen by ' +
                            'anyone, while private accounts can only be ' +
                            'seen by your followers.',
                        style: GoogleFonts.dmSans(
                            color: Colors.grey, fontSize: 15)),
                  ),
                  ListTile(
                    title: Text('Account Type',
                        style: GoogleFonts.dmSans(color: Colors.white)),
                    subtitle: Text(
                        ispublic.value
                            ? 'Your Account is Public'
                            : 'Your Account is Private',
                        style: GoogleFonts.dmSans(color: Colors.grey)),
                    trailing: Obx(() => CupertinoSwitch(
                        value: ispublic.value,
                        onChanged: (value) async {
                          ispublic.value = value;
                          final request = ModelMutations.update(guserData!
                              .copyWith(
                                  accountType:
                                      ispublic.value ? 'Public' : 'Private'));
                          final response = await Amplify.API
                              .mutate(request: request)
                              .response;
                          guserData = response.data;
                          Get.log(response.data.toString());
                        })),
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.grey),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('Activity Status',
                        style: GoogleFonts.dmSans(color: Colors.white)),
                    subtitle: Text(
                        'Show your activity status to others when you are online',
                        style: GoogleFonts.dmSans(color: Colors.grey)),
                    trailing: Obx(() => CupertinoSwitch(
                        value: isstatusallowd.value ?? false,
                        onChanged: (value) async {
                          isstatusallowd.value = value;
                          final request = ModelMutations.update(guserData!
                              .copyWith(
                                  showActivityStatus:
                                      isstatusallowd.value ?? false));
                          final response = await Amplify.API
                              .mutate(request: request)
                              .response;
                          guserData = response.data;
                          Get.log(response.data.toString());
                        })),
                  ),
                ]),
              ));
            },
            leading: Icon(Icons.lock, color: Colors.white),
            title: Text('Privacy', style: TextStyle(color: Colors.white)),
            subtitle: Text('Change your privacy settings',
                style: TextStyle(color: Colors.grey[400])),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          // ListTile(
          //   leading: Icon(Icons.shield, color: Colors.white),
          //   title: Text('Security', style: TextStyle(color: Colors.white)),
          //   subtitle: Text('Password and others',
          //       style: TextStyle(color: Colors.grey[400])),
          //   trailing:
          //       Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          // ),
          ListTile(
            onTap: () async {
              final mailtoLink = Mailto(
                to: ['dekhoapp2022@gmail.com'],
                subject: 'Applicaton for Verified Badge',
                body: ' ',
              );
              // Convert the Mailto instance into a string.
              // Use either Dart's string interpolation
              // or the toString() method.
              await launch('$mailtoLink');
            },
            leading: Icon(Icons.verified_sharp, color: Colors.white),
            title: Text('Get Verified Badge',
                style: TextStyle(color: Colors.white)),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () => Get.to(() => SettingsAccount()),
            leading: Icon(Icons.person, color: Colors.white),
            title: Text('Account', style: TextStyle(color: Colors.white)),
            subtitle: Text('Request data, delete account etc.',
                style: TextStyle(color: Colors.grey[400])),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () async {
              final mailtoLink = Mailto(
                to: ['dekhoapp2022@gmail.com'],
                subject: 'Help & Support',
                body: ' ',
              );
              // Convert the Mailto instance into a string.
              // Use either Dart's string interpolation
              // or the toString() method.
              await launch('$mailtoLink');
            },
            leading: Icon(Icons.support, color: Colors.white),
            title:
                Text('Help & Support', style: TextStyle(color: Colors.white)),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () => Get.dialog(Scaffold(
                appBar: AppBar(
                  title: Text('About'),
                  leading: IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.close)),
                  backgroundColor: Colors.black,
                  actions: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Version 1.0.0',
                        style: GoogleFonts.poppins(),
                      ),
                    ))
                  ],
                ),
                body: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                      alignment: Alignment.center,
                      child: Text('Dekho',
                          style: GoogleFonts.poppins(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                          'A Social Media App for Indians, chat with your friends, share your thoughts and earn money, While doing so much more',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Developed and owned by ',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              )),
                          InkWell(
                            onTap: () async {
                              final url = Uri.parse('https://mythicsstudio.in');
                              // launch url
                              if (await canLaunchUrl(url)) {
                                launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Text('Mythics Studio',
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.pinkAccent)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/mii.png',
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 10),
                          Text('Made In India',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                      alignment: Alignment.bottomCenter,
                      child:
                          Text('Proud to be an Indian | भारतीय होने पर गर्व है',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.pinkAccent,
                              )),
                    ),
                  ],
                ))),
            leading: Icon(Icons.info_sharp, color: Colors.white),
            title: Text('About', style: TextStyle(color: Colors.white)),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()));
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('userid');

              await Amplify.Auth.signOut().then((value) async {
                isSignedin = false;
                userid = '';

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthHero()),
                    (route) => false);
              });
            },
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
