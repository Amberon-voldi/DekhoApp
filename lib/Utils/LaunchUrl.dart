import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchlinks(context, IosLink, AndriodLink) async {
  if (Platform.isIOS) {
    final link = Uri.parse(IosLink);
    if (await canLaunchUrl(link)) {
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text('Unable to connect with the app')));
    }
  } else {
    final link = Uri.parse(AndriodLink);
    if (await canLaunchUrl(link)) {
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text('Unable to connect with the app')));
    }
  }
}
