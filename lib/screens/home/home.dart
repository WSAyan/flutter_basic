import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/background/push_notification.dart';
import 'package:flutter_basic/data/notification.dart';
import 'package:flutter_basic/local/db_helper.dart';
import 'package:flutter_basic/local/repository.dart';
import 'package:flutter_basic/screens/home/drawer.dart';
import 'package:flutter_basic/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  FCMHelper fcmHelper = new FCMHelper();
  int notificationCount = 0;
  NotificationRepository notificationRepository;

  @override
  void initState() {
    super.initState();

    fcmHelper.handlePushNotification(onNewNotification);

    DBHelper.instance.initDb();
    notificationRepository = NotificationRepository(DBHelper.instance);
  }

  @override
  Widget build(BuildContext context) {
    IconButton notificationIcon = IconButton(
      icon: Icon(
        Icons.notifications,
        color: Colors.white,
      ),
      onPressed: onNotificationIconPressed,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.HOME_SCREEN_TITLE),
        actions: <Widget>[
          notificationCount == 0
              ? notificationIcon
              : Badge(
                  shape: BadgeShape.circle,
                  position: BadgePosition.topEnd(top: 5, end: 0),
                  badgeContent: Text(notificationCount.toString()),
                  child: notificationIcon,
                ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to",
            ),
            Text(
              "Neverland",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      drawer: SideNavDrawer(),
    );
  }

  Future onNewNotification(Map<String, dynamic> message) async {
    setState(() {
      notificationCount++;
    });

    saveNotification(message['notification']['title'],
        message['notification']['body'], false);
  }

  void onNotificationIconPressed() {
    setState(() {
      notificationCount = 0;
    });
  }

  void saveNotification(String title, String body, bool isRead) {
    NotificationData notification = new NotificationData();
    notification.title = title;
    notification.body = body;
    notification.isRead = !isRead ? 0 : 1;
    notificationRepository
        .insert(notification)
        .then((value) => log('data: ${value.title}'));
  }
}
