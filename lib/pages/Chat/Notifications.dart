import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/main.dart';
import 'package:dekho/widgets/notSignedin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controlers/AppData/AppdataController.dart';
import '../../models/Follow.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final appData = GetIt.instance<AppData>();
  @override
  Widget build(BuildContext context) {
    return !isSignedin
        ? NotSignedIn()
        : Scaffold(
            backgroundColor: Colors.black,
            body: appData.followrequests.isEmpty
                ? Container(
                    child: Center(
                      child: Text(
                        'Nothing here',
                        style: GoogleFonts.dmSans(color: Colors.white),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: appData.followrequests.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(appData
                                  .followrequests[index].pfp ??
                              'https://imgs.search.brave.com/S87HblOW0d_hSc5e8ZD1fnQHRQodTOmqDgCuMN7iG5I/rs:fit:464:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC51/ZElmbVhrRFR6d3VE/RjRZS1BIQlBnSGFI/ayZwaWQ9QXBp'),
                        ),
                        title: Text(
                          appData.followrequests[index].username == null
                              ? '@username'
                              : '@${appData.followrequests[index].username}',
                          style: GoogleFonts.dmSans(color: Colors.white),
                        ),
                        subtitle: Text(
                          'wants to follow you',
                          style: GoogleFonts.dmSans(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final request = ModelMutations.update(
                                    appData.followrequests[index].copyWith(
                                  accepted: true,
                                ));

                                appData.followrequests
                                    .remove(appData.followrequests[index]);
                                if (mounted) setState(() {});
                                final response = await Amplify.API
                                    .mutate(request: request)
                                    .response;
                                print(response);
                                Fluttertoast.showToast(
                                    msg: 'Request Accepted',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final request = ModelMutations.deleteById(
                                    Follow.classType,
                                    appData.followrequests[index].id);
                                appData.followrequests
                                    .remove(appData.followrequests[index]);
                                if (mounted) setState(() {});
                                final response = await Amplify.API
                                    .mutate(request: request)
                                    .response;
                                print(response);
                                Fluttertoast.showToast(
                                    msg: 'Request Rejected',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    })));
  }
}
