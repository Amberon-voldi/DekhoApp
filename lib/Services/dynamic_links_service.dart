import 'package:dekho/pages/Account/AccountPage.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // 2. handle link that has been retrieved
    if (data != null) {
      _handleDeepLink(data!);
    }

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink;
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var isPost = deepLink.pathSegments.contains('username');

      if (isPost) {
        // get the title of the post
        var title = deepLink.queryParameters['username'];

        if (title != null) {
          print('tried handling the deeplink');
          // if we have a post navigate to the CreatePostViewRoute and pass in the title as the arguments.
          Get.to(AccountPage(
            doit: false,
          ));
        }
      }
    }
  }
}
