import 'package:flutter_basic/data/notification.dart';
import 'package:flutter_basic/local/dao.dart';
import 'package:flutter_basic/local/db_helper.dart';

class NotificationRepository {
  final dao = NotificationDao();
  DBHelper dbHelper;

  NotificationRepository(this.dbHelper);

  Future<NotificationData> insert(NotificationData notification) async {
    final db = await dbHelper.initDb();
    notification.id = await db.insert(dao.tableName, dao.toMap(notification));
    return notification;
  }

  @override
  Future<NotificationData> delete(NotificationData notification) async {
    final db = await dbHelper.initDb();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [notification.id]);
    return notification;
  }

  @override
  Future<NotificationData> update(NotificationData notification) async {
    final db = await dbHelper.initDb();
    await db.update(dao.tableName, dao.toMap(notification),
        where: dao.columnId + " = ?", whereArgs: [notification.id]);
    return notification;
  }

  @override
  Future<List<NotificationData>> getNotifications() async {
    final db = await dbHelper.initDb();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}
