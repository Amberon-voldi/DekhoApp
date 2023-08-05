import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_datastore/amplify_datastore_stream_controller.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:camera/camera.dart';
import 'package:dekho/Controlers/AppData/AppdataController.dart';
import 'package:dekho/Controlers/Chat/ChatController.dart';
import 'package:dekho/Controlers/Posts/PostsController.dart';

import 'package:dekho/Services/dynamic_links_service.dart';
import 'package:dekho/amplifyconfiguration.dart';
import 'package:dekho/landingPage.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:dekho/pages/UploadVideo/CameraPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/AuthHero.dart';

import 'Controlers/Reels/ReelsVideoController.dart';
import 'Utils/variables.dart';

late List<CameraDescription> cameras;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
bool isSignedin = false;
final locator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await _configureAmplify().then((value) async {
    locator.registerSingleton<AppData>(AppData());
    locator.registerSingleton<FeedViewModel>(FeedViewModel());
    locator.registerSingleton<PostsViewModel>(PostsViewModel());
    locator.registerSingleton<ChatController>(ChatController());
    final ap = GetIt.instance<AppData>();
    final a = GetIt.instance<FeedViewModel>();
    await a.load();
    ap.getuserid();
    ap.getsearch();
  });
  // initialise firebase and all related stuff
  // await Firebase.initializeApp();
  // hide top task bar
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  // DynamicLinkService().handleDynamicLinks();

  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.addPlugin(AmplifyStorageS3());
    await Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));
    await Amplify.addPlugin(
        AmplifyDataStore(modelProvider: ModelProvider.instance));
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    print('Could not configure Amplify: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  checkUser() async {
    // final user = await Amplify.Auth.fetchAuthSession();

    // setState(() {
    //   isSignedin = user.isSignedIn;
    // });
    // final prefs = await SharedPreferences.getInstance();
    // final key = prefs.getString('userid');

    // final userAttributes = await Amplify.Auth.fetchUserAttributes();
    // print(userAttributes);
    // final queryPredicate = User.EMAIL.eq(userAttributes[3].value.toString());
    // Get.log(userAttributes[3].value.toString());

    // final request =
    //     ModelQueries.list<User>(User.classType, where: queryPredicate);
    // final response = await Amplify.API.query(request: request).response;

    // final iserinfo = response.data?.items.first;

    // await prefs.setString('userid', iserinfo!.id);

    // userid = iserinfo.id;
    // username = iserinfo.username!;
    // useremail = iserinfo.email!;
    // userbio = iserinfo.bio!;
    // userpfp = iserinfo.pfp!;
    // print('Asigned user info');
  }

  final primarySwatch = Color.fromARGB(255, 4, 51, 89);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dekho',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primarySwatch,
          secondary: primarySwatch,
          surface: primarySwatch,
          background: primarySwatch,
          error: primarySwatch,
          onPrimary: primarySwatch,
          onSecondary: primarySwatch,
          onSurface: primarySwatch,
          onBackground: primarySwatch,
          onError: primarySwatch,
        ),

        primarySwatch: Colors.blue,
      ),
      home: isSignedin ? LandingPage() : AuthHero(),
    );
  }
}
