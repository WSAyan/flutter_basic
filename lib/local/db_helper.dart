import 'package:flutter_basic/local/dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_NAME = "flutter_basic.db";

class DBHelper {
  static final instance = DBHelper.internal();
  static DBHelper get = instance;
  bool isInitialized = false;
  Database db;

  DBHelper.internal();

  Future<Database> initDb() async {
    if (!isInitialized) await init();
    return db;
  }

  Future init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(NotificationDao().createTableQuery);
    });
  }
}
