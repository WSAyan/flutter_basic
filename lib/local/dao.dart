import 'package:flutter_basic/data/notification.dart';

abstract class BaseDao<T> {
  String get createTableQuery;

  T fromMap(Map<String, dynamic> query);

  List<T> fromList(List<Map<String, dynamic>> query);

  Map<String, dynamic> toMap(T object);
}

class NotificationDao implements BaseDao<NotificationData> {
  final String tableName = "notifications";
  final String columnId = "id";
  final String title = "title";
  final String body = "body";
  final String isRead = "isRead";

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
          " $title TEXT,"
          " $body TEXT,"
          " $isRead INTEGER)";

  @override
  List<NotificationData> fromList(List<Map<String, dynamic>> query) {
    List<NotificationData> notifications = List<NotificationData>();
    for (Map map in query) {
      notifications.add(fromMap(map));
    }
    return notifications;
  }

  @override
  NotificationData fromMap(Map<String, dynamic> query) {
    return NotificationData.fromMap(query);
  }

  @override
  Map<String, dynamic> toMap(NotificationData notification) {
    return notification.toMap();
  }
}

