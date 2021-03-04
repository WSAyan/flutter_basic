import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_basic/data/notification.dart';
import 'package:flutter_basic/local/db_helper.dart';
import 'package:flutter_basic/local/repository.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<NotificationsScreen> {
  List<NotificationData> notifications = new List<NotificationData>();
  Future<List<NotificationData>> futureNotifications;
  NotificationRepository notificationRepository;

  @override
  void initState() {
    super.initState();

    notificationRepository = NotificationRepository(DBHelper.instance);
    futureNotifications = notificationRepository.getNotifications();
  }

  Widget buildNotificationsList() {
    //paginationController(7, 1, 6); // hard coded

    return FutureBuilder<List<NotificationData>>(
        future: futureNotifications,
        builder: (context, snapshot) {
          log("${snapshot.data}");
          if (snapshot.hasData) {
            notifications.clear();
            notifications.addAll(snapshot.data);

            return ScrollablePositionedList.builder(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  NotificationData notificationData = notifications[index];

                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        onDeleteClick(notificationData);
                      },
                    ),
                    title: Text(
                      notificationData.title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Text(notificationData.body),
                    onTap: () {
                      onListItemClick(notificationData);
                    },
                  );
                });
          }

          return Center(child: CommonAppWidgets.makeCommonLoader());
        });
  }

  void onListItemClick(Object data) {
    NotificationData notificationData = data as NotificationData;
    notificationData.isRead = 1;
    notificationRepository
        .update(notificationData)
        .then((value) => log('data: ${value.isRead}'));
  }

  void onDeleteClick(NotificationData notificationData) {
    notificationRepository.delete(notificationData).then(
        (value) => CommonAppWidgets.showCommonToast("Notification deleted"));

    setState(() {
      futureNotifications = notificationRepository.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.NOTIFICATIONS_SCREEN_TITLE),
      ),
      body: buildNotificationsList(),
    );
  }
}
