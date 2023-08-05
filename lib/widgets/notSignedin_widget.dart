import 'package:dekho/Auth/AuthHero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';

class NotSignedIn extends StatelessWidget {
  const NotSignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBroken.add_user,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please Sign in to view your profile',
              style: GoogleFonts.dmSans(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SignIn(),
                //   ),
                // );
                Get.to(() => AuthHero(), arguments: 'signin');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sign in',
                  style: GoogleFonts.dmSans(color: Colors.black),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
