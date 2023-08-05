import 'package:dekho/pages/Chat/ChatPage.dart';
import 'package:dekho/pages/Chat/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controlers/AppData/AppdataController.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final appData = GetIt.instance<AppData>();
  final title = 'Chats';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: GoogleFonts.dmSans(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.black,
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[400],
                indicatorWeight: 1,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                  ),
                  Tab(
                      icon: Stack(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      if (appData.followrequests.isNotEmpty)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              appData.followrequests.length.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  )),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  ChatPage(),
                  NotificationPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
