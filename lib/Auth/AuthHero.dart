import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekho/main.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../Controlers/AppData/AppdataController.dart';
import '../Utils/variables.dart';
import '../landingPage.dart';

class AuthHero extends StatefulWidget {
  const AuthHero({super.key});

  @override
  State<AuthHero> createState() => _AuthHeroState();
}

class _AuthHeroState extends State<AuthHero> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool showpassword = true;
  bool loaddd = false;
  final ap = GetIt.instance<AppData>();

  Future<void> signInWithGoogle() async {
    try {
      showDialog(
          context: context,
          builder: (context) => Center(child: CircularProgressIndicator()));
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      result;
      print('Result: $result');
      fetchuserattributes();
    } on AmplifyException catch (e) {
      print("error " + e.toString());
      Navigator.pop(context);
    }
  }

  void fetchuserattributes() async {
    try {
      final userAttributes = await Amplify.Auth.fetchUserAttributes();
      print(userAttributes);
      final queryPredicate = User.ID.eq(userAttributes[0].value.toString());

      final request =
          ModelQueries.list<User>(User.classType, where: queryPredicate);
      final response = await Amplify.API.query(request: request).response;
      print(response.data);
      if (response.data!.items.length.toString() == '0' ||
          response.data == null) {
        int random(int min, int max) {
          return min + Random().nextInt(max - min);
        }

        final userna =
            userAttributes[3].value.split(' ').first.replaceAll(' ', '') +
                random(1111, 9999).toString();

        final item = User(
            id: userAttributes[0].value.toString(),
            email: userAttributes[4].value.toString(),
            name: userAttributes[3].value.toString(),
            username: userna,
            showActivityStatus: true,
            verified: false,
            nameLowerCase: userAttributes[3].value.toString().toLowerCase(),
            accountType: 'Public',
            pfp: userAttributes[5].value.toString());

        final request = ModelMutations.create(item);
        final response = await Amplify.API.mutate(request: request).response;
        print(response.data);

        final box = GetStorage();
        box.write('userid', response.data!.id);

        userid = response.data!.id;
        guserData = response.data!;

        isSignedin = true;
        print(userid);
        ap.getUserPosts();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
            (route) => false);

        return;
      }
      final iserinfo = response.data?.items.first;

      final box = GetStorage();
      box.write('userid', iserinfo!.id);

      userid = iserinfo.id;
      guserData = iserinfo;
      isSignedin = true;
      print(userid);
      ap.getUserPosts();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
          (route) => false);
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            if (Get.arguments == 'signin') {
              Get.back();
            } else {
              Get.off(() => LandingPage());
            }
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/authbg.jpg'), fit: BoxFit.cover)),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Colors.black.withOpacity(0.5),
              Colors.transparent,
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Column(
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              child: Column(children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Welcome to Dekho',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Text(
                    'Sign in or create an accout to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
            Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  signInWithGoogle();
                },
                leading: Icon(
                  UniconsLine.google,
                  color: Colors.black,
                ),
                title: Text(
                  'Continue with Google',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  UniconsLine.arrow_right,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "By continuing, you agree to our terms of service and privacy policy",
                maxLines: 2,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ]),
    );
  }

  String? errorMessage;

  Future<void> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      final Userss = await Amplify.DataStore.query(User.classType,
          where: User.EMAIL.eq(emailController.text));
      if (Userss == null) {
        Fluttertoast.showToast(
            msg:
                'It seems we already have your data, try using in same email and Create Account');
      } else {
        try {
          await Amplify.Auth.signIn(
            username: emailController.text.trim(),
            password: passwordController.text.trim(),
          ).then((value) async {
            setState(() {
              loaddd = false;
              isSignedin = true;
            });

            final queryPredicate = User.EMAIL.eq(emailController.text);

            final request =
                ModelQueries.list<User>(User.classType, where: queryPredicate);
            final response = await Amplify.API.query(request: request).response;
            final iserinfo = response.data?.items.first;

            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('email', emailController.text);
            await prefs.setString('userid', iserinfo!.id);
            userid = iserinfo.id;
            await prefs.setStringList('users',
                <String>[emailController.text, passwordController.text]);
//             final externalUserId = emailController
//                 .text; // You will supply the external user id to the OneSignal SDK
//             // Pass in email provided by customer
//             OneSignal.shared.setEmail(email: emailController.text);

// // Pass in phone number provided by customer

//             OneSignal.shared.setExternalUserId(externalUserId);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
                (route) => false);
          });
          setState(() {});
        } on AuthException catch (error) {
          switch (error.message) {
            case "invalid-email":
              errorMessage = "Your email address appears to be malformed.";

              break;
            case "wrong-password":
              errorMessage = "Your password is wrong.";
              break;
            case "user-not-found":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "user-disabled":
              errorMessage = "User with this email has been disabled.";
              break;
            case "too-many-requests":
              errorMessage = "Too many requests";
              break;
            case "operation-not-allowed":
              errorMessage =
                  "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Navigator.pop(context);
          Fluttertoast.showToast(msg: error.message);

          print(error);
        }
      }
    } else {
      Navigator.pop(context);
    }
  }
}
